import 'dart:async';
import 'dart:developer';

import 'dart:io';
import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/connection/connection_listener.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/model/response.dart' as response;
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// ExceptionHandlerMixin
///
/// This is a "Mixin" - a piece of code we can add to other classes (like NetworkService).
/// It handles COMMMON errors so we don't have to write try-catch blocks everywhere.
///
/// What it handles:
/// 1. No Internet connection.
/// 2. Unauthorized (401) -> Automatically logs user out.
/// 3. Server errors (500).
/// 4. Timeouts.
mixin ExceptionHandlerMixin on NetworkService {
  final HiveService _hiveService = GetIt.instance<HiveService>();
  UserPreferences? userPreferences;
  NetworkService? networkService;

  /// Main handler function. Wraps an API call.
  ///
  /// Usage:
  /// ```dart
  /// return handleException(() => dio.get(...));
  /// ```
  Future<Either<AppException, response.Response>>
  handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    var connectionStatus = ConnectionStatusListener.getInstance();

    // 1. Check Internet first
    if (await connectionStatus.checkConnection()) {
      try {
        // 2. Try the API call
        Response<dynamic> res = await handler();

        // 3. If success, return Right (Success data)
        return Right(
          response.Response(
            statusCode: res.statusCode ?? 200,
            data: res.data,
            statusMessage: res.statusMessage,
          ),
        );
      } catch (e) {
        // 4. If error (catch block), figure out what happened
        String message = '';
        String identifier = '';
        int statusCode = 0;

        if (e is DioException) {
          // Special Case: Session Expired (401)
          if (e.response?.statusCode == 401) {
            log("Unauthorized - Triggering logout...${e.response?.statusCode}");
            logout();

            return Left(
              AppException(
                message: AppStrings.sessionExpiryMsg,
                statusCode: 401,
                identifier: 'Unauthorized at $endpoint',
              ),
            );
          }

          // Extract readable message from backend
          final responseData = e.response?.data;
          if (responseData is Map<String, dynamic> &&
              responseData.containsKey('message')) {
            message = responseData['message'];
          } else {
            message = e.message ?? AppStrings.errorOccurred;
          }
          statusCode = e.response?.statusCode ?? 0;
          identifier = 'DioException ${e.message} \nat $endpoint';
        } else if (e is SocketException) {
          message = AppStrings.unableToConnect;
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at $endpoint';
        } else {
          message = AppStrings.unknownError;
          statusCode = 0;
          identifier = 'Unknown error ${e.toString()}\n at $endpoint';
        }

        // Return the error
        return Left(
          AppException(
            message: message,
            statusCode: statusCode,
            identifier: identifier,
          ),
        );
      }
    } else {
      // No Internet
      log("No internet");
      return Left(
        AppException(
          message: AppStrings.noInternetMsg,
          statusCode: 0,
          identifier: 'No Internet at $endpoint',
        ),
      );
    }
  }

  /// Logs user out if session expired
  void logout() async {
    await _hiveService.clear();
    userPreferences?.clearPreferences();
    networkService?.updateHeader({'Authorization': ''});
    nav();
  }

  /// Redirect to Login
  void nav() {
    navigatorKey.currentState?.context.go(RoutesName.loginPath);
  }
}

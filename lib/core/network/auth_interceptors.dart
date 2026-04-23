import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/model/refresh_token_response.dart';
import 'package:bloc_advanced/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// AuthInterceptors
///
/// Handles automatic token refresh when a 401 Unauthorized error occurs,
/// or when the access token is detected as expired.
class AuthInterceptors extends Interceptor {
  final Dio dio;

  AuthInterceptors({required this.dio});

  final _hiveService = GetIt.instance<HiveService>();

  void setNewToken(String token) {
    _hiveService.set(userToken, token);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestPath = err.requestOptions.path;

    // If the refresh token request itself fails, go to login
    if (requestPath.contains(ApiEndpoint.refreshToken)) {
      Future.microtask(() {
        router.go(RoutesName.loginPath);
      });
      return handler.next(err);
    }

    final token = await _hiveService.get(refreshToken) as String?;
    final access = await _hiveService.get(userToken) as String?;

    // Check for specific backend messages or missing tokens
    if (access == null || 
        token == null ||
        err.response?.data['message'] == 'User is inactive or deleted, please contact admin') {
      router.go(RoutesName.loginPath);
      return handler.next(err);
    } else {
      bool isExpired = JwtDecoder.isExpired(access);

      try {
        if (err.response?.statusCode == 401 || isExpired) {
          final response = await dio.post(
            ApiEndpoint.refreshToken,
            options: Options(headers: {'cookie': 'refresh_token=$token'}),
          );

          RefreshTokenResponse refreshTokenResponse =
              RefreshTokenResponse.fromJson(response.data);
          setNewToken(refreshTokenResponse.data.accessToken);

          final options = err.requestOptions;

          options.headers['Authorization'] =
              'Bearer ${refreshTokenResponse.data.accessToken}';

          // Retry the original request with the new token
          final retryResponse = await dio.fetch(options);

          // Return the new response to the original caller
          return handler.resolve(retryResponse);
        }
      } on Exception catch (e) {
        debugPrint('AuthInterceptors Error: ${e.toString()}');
        router.go(RoutesName.loginPath);
      }
    }
    super.onError(err, handler);
  }
}

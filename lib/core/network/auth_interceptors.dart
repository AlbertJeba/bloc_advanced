import 'dart:developer';

import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/logout_service_function.dart';
import 'package:bloc_advanced/core/network/model/refresh_token_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// AuthInterceptors
///
/// Production enterprise interceptor handling:
/// 1. Automatic Bearer token injection on outgoing non-auth requests
/// 2. Auth endpoint exclusions (preventing refresh loops on login/register)
/// 3. Concurrency-protected token refresh queue on 401 Unauthorized
/// 4. Graceful fallback to LogoutService on token revocation
class AuthInterceptors extends Interceptor {
  final Dio dio;

  AuthInterceptors({required this.dio});

  final _hiveService = GetIt.instance<HiveService>();

  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})>
  _queue = [];

  bool _isAuthEndpoint(String path) {
    return path.contains(ApiEndpoint.login) ||
        path.contains(ApiEndpoint.register) ||
        path.contains(ApiEndpoint.refreshToken) ||
        path.contains('auth/signup') ||
        path.contains('auth/forgot-password') ||
        path.contains('auth/reset-password') ||
        path.contains('auth/verify-otp');
  }

  void setNewToken(String token) {
    _hiveService.set(userToken, token);
  }

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler,) async {
    final isExternal =
        options.path.startsWith('http://') ||
            options.path.startsWith('https://');

    // Automatically inject Bearer token for internal, non-auth endpoints
    if (!isExternal && !_isAuthEndpoint(options.path)) {
      final token = await _hiveService.get(userToken) as String?;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    if (!isExternal) {
      options.headers['Accept'] = 'application/json';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestPath = err.requestOptions.path;

    // Do not intercept or retry auth endpoints
    if (_isAuthEndpoint(requestPath)) {
      if (requestPath.contains(ApiEndpoint.refreshToken)) {
        log('Refresh token endpoint failed. Clearing session.');
        await LogoutService.instance.clearData();
      }
      return handler.next(err);
    }

    // Do not retry if request already failed on a retry attempt
    if (err.requestOptions.extra['isRetry'] == true) {
      log(
        'Retry request failed for ${err.requestOptions
            .path}. Redirecting to logout.',
      );
      await LogoutService.instance.clearData();
      return handler.next(err);
    }

    final token = await _hiveService.get(refreshToken) as String?;
    final access = await _hiveService.get(userToken) as String?;

    // Check for missing session tokens or deactivated account message
    final data = err.response?.data;
    final isUserInactive =
        data is Map &&
            data['message'] ==
                'User is inactive or deleted, please contact admin';

    if (token == null || token.isEmpty || isUserInactive) {
      log('No refresh token available or inactive user. Logging out.');
      await LogoutService.instance.clearData();
      return handler.next(err);
    }

    bool isExpired = false;
    if (access != null && access.isNotEmpty) {
      try {
        isExpired = JwtDecoder.isExpired(access);
      } catch (_) {
        isExpired = true;
      }
    } else {
      isExpired = true;
    }

    if (err.response?.statusCode == 401 || isExpired) {
      // If a refresh is already in progress, enqueue this failed request
      if (_isRefreshing) {
        log(
          'Token refresh in progress. Enqueueing request: ${err.requestOptions
              .path}',
        );
        _queue.add((options: err.requestOptions, handler: handler));
        return;
      }

      _isRefreshing = true;
      log(
        'Initiating single-lock token refresh for: ${err.requestOptions.path}',
      );

      try {
        final response = await dio.post(
          ApiEndpoint.refreshToken,
          data: {'refreshToken': token},
        );

        final refreshTokenResponse = RefreshTokenResponse.fromJson(
          response.data,
        );
        final newAccessToken = refreshTokenResponse.data.accessToken;

        if (newAccessToken.isEmpty) {
          throw Exception('Empty access token received from refresh endpoint');
        }

        setNewToken(newAccessToken);
        if (refreshTokenResponse.data.refreshToken != null &&
            refreshTokenResponse.data.refreshToken!.isNotEmpty) {
          await _hiveService.set(
            refreshToken,
            refreshTokenResponse.data.refreshToken!,
          );
        }
        dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

        // 1. Retry the original request
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        retryOptions.extra['isRetry'] = true;

        log('Retrying original request: ${retryOptions.path}');
        final originalResponse = await dio.fetch(retryOptions);
        handler.resolve(originalResponse);

        // 2. Retry all queued requests with the fresh token
        for (final item in _queue) {
          final queuedOptions = item.options;
          queuedOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          queuedOptions.extra['isRetry'] = true;
          try {
            log('Retrying queued request: ${queuedOptions.path}');
            final queuedResponse = await dio.fetch(queuedOptions);
            item.handler.resolve(queuedResponse);
          } on DioException catch (dioErr) {
            item.handler.reject(dioErr);
          }
        }
      } catch (e) {
        debugPrint('AuthInterceptors Refresh Failure: ${e.toString()}');
        // Reject all queued requests
        for (final item in _queue) {
          item.handler.reject(err);
        }
        await LogoutService.instance.clearData();
        return handler.next(err);
      } finally {
        _queue.clear();
        _isRefreshing = false;
      }
      return;
    }

    super.onError(err, handler);
  }
}

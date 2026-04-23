import 'package:bloc_advanced/core/exceptions/exception_handler_mixin.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'auth_interceptors.dart';
import 'model/either.dart';
import 'model/response.dart' as response;
import 'network_service.dart';

/// DioNetworkService
///
/// This class handles all API calls using the Dio package.
/// Now enhanced with AuthInterceptors and 5000ms timeouts.
class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  late final Dio _dio;

  DioNetworkService() {
    _dio = Dio();
    _dio.options = dioBaseOptions;

    // Add Auth Interceptor for token management
    _dio.interceptors.add(AuthInterceptors(dio: _dio));

    // Add Logger only in Debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          queryParameters: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          showProcessingTime: true,
          canShowLog: kDebugMode,
        ),
      );
    }
  }

  /// Default configurations (Base URL, Headers, Timeouts)
  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        sendTimeout: const Duration(milliseconds: 5000),
      );

  @override
  String get baseUrl => EnvInfo.baseUrl;

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  /// Update headers (e.g., adding Auth Token after login)
  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    Map<String, dynamic> header = {...data, ...headers};
    _dio.options.headers = header;
    return header;
  }

  // --- HTTP Methods ---

  @override
  Future<Either<AppException, response.Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    // handleException wraps the call to catch errors automatically
    Future<Either<AppException, response.Response>> res = handleException(
      () => _dio.post(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Future<Either<AppException, response.Response>> res = handleException(
      () => _dio.get(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    Future<Either<AppException, response.Response>> res = handleException(
      () => _dio.put(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Future<Either<AppException, response.Response>> res = handleException(
      () => _dio.delete(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
    );
    return res;
  }

  /// Upload files (images, documents)
  Future<Either<AppException, response.Response>> uploadFile(
    String endpoint,
    FormData formData,
  ) async {
    Future<Either<AppException, response.Response>> res = handleException(
      () => _dio.post(endpoint, data: formData),
      endpoint: endpoint,
    );
    return res;
  }
}

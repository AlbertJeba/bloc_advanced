import 'package:bloc_advanced/core/exceptions/exception_handler_mixin.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'model/either.dart';
import 'model/response.dart' as response;
import 'network_service.dart';

/// DioNetworkService
///
/// This class handles all API calls using the Dio package.
///
/// What is Dio?
/// - A powerful HTTP client for Dart/Flutter.
/// - It supports interceptors, global configuration, FormData, etc.
///
/// What this class does:
/// 1. Sets up Dio with base URL and headers.
/// 2. Adds logging (only in Debug mode) to see API requests/responses in console.
/// 3. Provides methods for GET, POST, PUT, DELETE.
/// 4. Handles errors globally using ExceptionHandlerMixin.
class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  late final Dio _dio;

  DioNetworkService() {
    _dio = Dio();
    _dio.options = dioBaseOptions;

    // Add Logger only in Debug mode (so users don't see logs in Prod)
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

    // Interceptor to handle responses globally if needed
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
  }

  /// Default configurations (Base URL, Headers)
  BaseOptions get dioBaseOptions =>
      BaseOptions(baseUrl: baseUrl, headers: headers);

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

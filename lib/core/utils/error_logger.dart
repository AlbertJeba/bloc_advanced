import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:flutter/foundation.dart';

/// ErrorLogger
///
/// A helper class to standardize how we handle and print errors.
class ErrorLogger {
  /// Logs an error to the console with a nice visual border.
  /// Only prints in Debug mode.
  static void log(String identifier, dynamic error) {
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔴 ERROR: $identifier');
    debugPrint('Details: ${error.toString()}');
    debugPrint('═══════════════════════════════════════');
  }

  /// Helps catch errors in DataSources and return them as an `AppException`.
  ///
  /// Usage:
  /// ```dart
  /// try {
  ///   // API call
  /// } catch (e) {
  ///   return ErrorLogger.handleException(e, 'ClassName.methodName');
  /// }
  /// ```
  static Left<AppException, T> handleException<T>(
    dynamic exception,
    String identifier, {
    String? customMessage,
  }) {
    // 1. Log to console
    log(identifier, exception);

    // 2. Return standard error object (Left)
    return Left(
      AppException(
        message: customMessage ?? AppStrings.unknownError,
        statusCode: 1,
        identifier: '${exception.toString()}\n$identifier',
      ),
    );
  }
}

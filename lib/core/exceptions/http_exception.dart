import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/model/response.dart';
import 'package:equatable/equatable.dart';

/// AppException
///
/// A standard custom exception class for our app.
/// Instead of using random strings or numbers, we use this object.
///
/// Contains:
/// - message: User-friendly error text.
/// - statusCode: HTML status code (404, 500) or 0 for local errors.
/// - identifier: Technical info for developers (where it happened).
class AppException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }
}

/// CacheFailureException
///
/// Specific error when local database (Hive) fails.
class CacheFailureException extends Equatable implements AppException {
  @override
  String get identifier => 'Cache failure exception';

  @override
  String get message => 'Unable to save user';

  @override
  int get statusCode => 100;

  @override
  List<Object?> get props => [message, statusCode, identifier];
}

/// Helper extension to easily convert an Exception to a "Left" (Error) return type.
extension HttpExceptionExtension on AppException {
  Left<AppException, Response> get toLeft => Left<AppException, Response>(this);
}

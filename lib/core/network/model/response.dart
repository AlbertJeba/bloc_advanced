import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'either.dart';

/// Response
///
/// A generic wrapper for any "Success" response from the API.
///
/// Contains:
/// - statusCode: 200, 201, etc.
/// - data: The actual JSON body.
class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  Response({
    required this.statusCode,
    this.statusMessage,
    this.data = const {},
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response {
  // Helper to convert to Either Type (Right side = Success)
  Right<AppException, Response> get toRight => Right(this);
}

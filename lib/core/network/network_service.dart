import 'package:bloc_advanced/core/exceptions/http_exception.dart';

import 'model/either.dart';
import 'model/response.dart';

/// NetworkService
///
/// This is an "Abstract Class" or Interface.
///
/// Why do we need this?
/// - It defines strict rules for any network service we create.
/// - It allows us to easily switch from Dio to another library (like Http) in the future without breaking the app.
/// - It makes testing easier because we can create a "FakeNetworkService".
abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  /// Updates headers (usually for adding the Auth Token)
  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, Response>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, Response>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}

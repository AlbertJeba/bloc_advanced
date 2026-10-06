import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/login/data/models/login_request.dart';
import 'package:bloc_advanced/features/login/data/models/login_response.dart';
import 'package:bloc_advanced/features/login/data/models/register_request.dart';

abstract class LoginRemoteDataSource {
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  });

  Future<Either<AppException, LoginResponse>> register({
    required RegisterRequest user,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final NetworkService networkService;

  LoginRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  }) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.login,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          LoginResponse loginResponse = LoginResponse.fromJson(response.data);

          if (loginResponse.accessToken != null &&
              loginResponse.accessToken!.isNotEmpty) {
            networkService.updateHeader({
              'Authorization': 'Bearer ${loginResponse.accessToken}',
            });
          }

          return Right(loginResponse);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(e, 'LoginRemoteDataSource.loginUser');
    }
  }

  @override
  Future<Either<AppException, LoginResponse>> register({
    required RegisterRequest user,
  }) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.register,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          LoginResponse loginResponse = LoginResponse.fromJson(response.data);

          if (loginResponse.accessToken != null &&
              loginResponse.accessToken!.isNotEmpty) {
            networkService.updateHeader({
              'Authorization': 'Bearer ${loginResponse.accessToken}',
            });
          }

          return Right(loginResponse);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'LoginRemoteDataSource.registerUser',
      );
    }
  }
}

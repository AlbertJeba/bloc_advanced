import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/profile/data/models/profile_response.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<AppException, ProfileResponse>> getProfile();

  Future<Either<AppException, ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkService networkService;

  ProfileRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, ProfileResponse>> getProfile() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.profile);
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = ProfileResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'ProfileRemoteDataSource.getProfile',
      );
    }
  }

  @override
  Future<Either<AppException, ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      Either eitherType = await networkService.put(
        ApiEndpoint.profile,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = ProfileResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'ProfileRemoteDataSource.updateProfile',
      );
    }
  }
}

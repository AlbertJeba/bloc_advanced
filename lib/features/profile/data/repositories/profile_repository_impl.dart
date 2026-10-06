import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:bloc_advanced/features/profile/data/models/profile_response.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';
import 'package:bloc_advanced/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, ProfileResponse>> getProfile() {
    return remoteDataSource.getProfile();
  }

  @override
  Future<Either<AppException, ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) {
    return remoteDataSource.updateProfile(request);
  }
}

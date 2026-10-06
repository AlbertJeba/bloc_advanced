import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/profile/data/models/profile_response.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';
import 'package:bloc_advanced/features/profile/domain/repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<Either<AppException, ProfileResponse>> getProfile() {
    return repository.getProfile();
  }

  Future<Either<AppException, ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) {
    return repository.updateProfile(request);
  }
}

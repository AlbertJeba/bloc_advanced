import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/profile/data/models/profile_response.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';

abstract class ProfileRepository {
  Future<Either<AppException, ProfileResponse>> getProfile();

  Future<Either<AppException, ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  );
}

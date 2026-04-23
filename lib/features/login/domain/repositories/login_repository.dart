import '../../../../core/exceptions/http_exception.dart';
import '../../../../core/network/model/either.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';

abstract class LoginRepository {
  Future<Either<AppException, LoginResponse>> loginUser(
      {required LoginRequest user});
}
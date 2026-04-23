import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/login/data/models/login_request.dart';
import 'package:bloc_advanced/features/login/data/models/login_response.dart';
import 'package:bloc_advanced/features/login/domain/repositories/login_repository.dart';

class LoginUseCases {
  final LoginRepository _loginRepository;

  const LoginUseCases(this._loginRepository);

  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  }) async {
    return _loginRepository.loginUser(user: user);
  }
}

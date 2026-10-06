import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/login/data/models/login_response.dart';
import 'package:bloc_advanced/features/login/data/models/register_request.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_use_case.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final LoginUseCases _loginUseCases;
  final HiveService _hiveService;
  final NetworkService _networkService;

  RegisterCubit(this._loginUseCases)
      : _hiveService = GetIt.instance<HiveService>(),
        _networkService = GetIt.instance<NetworkService>(),
        super(const RegisterState());

  void validateAndRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    String nameError = '';
    String emailError = '';
    String passwordError = '';

    if (name
        .trim()
        .isEmpty) {
      nameError = AppStrings.nameValidation;
    }

    if (email
        .trim()
        .isEmpty || !email.contains('@')) {
      emailError = AppStrings.emailValidation;
    }

    if (password.length < 6) {
      passwordError = AppStrings.passwordLengthValidation;
    }

    if (nameError.isNotEmpty || emailError.isNotEmpty ||
        passwordError.isNotEmpty) {
      emit(state.copyWith(
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(state.copyWith(nameError: '', emailError: '', passwordError: ''));
    register(RegisterRequest(
      name: name.trim(),
      email: email.trim(),
      phone: phone
          .trim()
          .isNotEmpty ? phone.trim() : null,
      password: password,
    ));
  }

  Future<void> register(RegisterRequest request) async {
    emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false));

    final result = await _loginUseCases.register(user: request);

    result.fold(
          (error) {
        ErrorLogger.log('RegisterCubit.register', error.identifier);
        emit(state.copyWith(
          isLoading: false,
          isFailure: true,
          isSuccess: false,
          errorMessage: error.message,
        ));
      },
          (response) {
        final userData = response.data?.user ?? UserData();

        // Save session in memory and encrypted Hive
        UserPreferences.instance.setUser(userData);
        final token = response.accessToken ?? '';
        final refToken = response.refreshToken ?? '';
        _hiveService.set(userToken, token);
        if (refToken.isNotEmpty) {
          _hiveService.set(refreshToken, refToken);
        }
        _hiveService.setUser(userData);
        _networkService.updateHeader({'Authorization': 'Bearer $token'});

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          registerData: response,
        ));
      },
    );
  }
}

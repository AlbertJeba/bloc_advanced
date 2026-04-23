import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/login/data/models/login_request.dart';
import 'package:bloc_advanced/features/login/data/models/login_response.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_usecase.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'login_state.dart';

/// LoginCubit - Handles all the login logic using the BLoC pattern.
///
/// What is a Cubit?
/// - A Cubit is a simpler version of BLoC (Business Logic Component)
/// - It manages "state" which is like a snapshot of the current situation
/// - When something changes, it "emits" a new state
/// - The UI listens to state changes and rebuilds automatically
///
/// What this cubit does:
/// 1. Validates username and password
/// 2. Makes API call to login
/// 3. Saves the user token to local storage
/// 4. Updates the network service with auth token
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCases _loginUseCases;
  final HiveService _hiveService;
  final NetworkService _networkService;

  /// Constructor - Sets up the cubit with its dependencies
  /// - _loginUseCases: Contains the login API call logic
  /// - _hiveService: For saving data locally (like the auth token)
  /// - _networkService: For updating API headers with the token
  LoginCubit(this._loginUseCases)
      : _hiveService = GetIt.instance<HiveService>(),
        _networkService = GetIt.instance<NetworkService>(),
        super(const LoginState());

  /// Validates inputs and starts login if valid.
  ///
  /// How it works:
  /// 1. Check if username is empty -> show error
  /// 2. Check if password is empty -> show error
  /// 3. If both are valid -> create login request and call API
  void validate(String username, String password) {
    String usernameError = '';
    String passwordError = '';

    if (username.isEmpty) {
      usernameError = AppStrings.usernameValidation;
    }

    if (password.isEmpty) {
      passwordError = AppStrings.passwordValidation;
    }

    if (usernameError.isNotEmpty || passwordError.isNotEmpty) {
      // Has errors - show them
      emit(state.copyWith(
        usernameError: usernameError,
        passwordError: passwordError,
      ));
    } else {
      // No errors - proceed with login
      LoginRequest request = LoginRequest(
        username: username,
        password: password,
        expiresInMins: tokenExpiryMins,
      );
      login(request);
    }
  }

  /// Makes the API call to login the user.
  ///
  /// How it works:
  /// 1. Show loading state
  /// 2. Call the login API via use case
  /// 3. If error -> Show error message
  /// 4. If success -> Save token and user data, then show success
  Future<void> login(LoginRequest user) async {
    // Show loading spinner
    emit(state.copyWith(isLoading: true));

    // Call the API
    Either result = await _loginUseCases.login(user: user);

    // Handle the result (Either is like a box that contains either an error or success)
    result.fold(
      // This runs if there's an error
      (error) {
        ErrorLogger.log('LoginCubit.login', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isLoading: false,
          isFailure: true,
          isSuccess: false,
        ));
      },
      // This runs if successful
      (loginResponse) {
        LoginResponse response = loginResponse as LoginResponse;

        // Create UserData object from the API response
        UserData userData = UserData(
          id: response.id,
          username: response.username,
          email: response.email,
          firstName: response.firstName,
          lastName: response.lastName,
          gender: response.gender,
          image: response.image,
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
        );

        // Save user data to memory (for quick access)
        UserPreferences userPreferences = UserPreferences.instance;
        userPreferences.setUser(userData);

        // Save token to Hive (local database)
        String token = response.accessToken ?? '';
        _hiveService.set(userToken, token);
        _hiveService.setUser(userData);

        // Add token to all future API requests
        _networkService.updateHeader({'Authorization': 'Bearer $token'});

        // Show success state
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          loginData: response,
        ));
      },
    );
  }

  /// Validates just the username field (called as user types)
  void validateUsername(String value) {
    String error = '';
    if (value.isEmpty) {
      error = AppStrings.usernameValidation;
    }
    emit(state.copyWith(usernameError: error));
  }

  /// Validates just the password field (called as user types)
  void validatePassword(String value) {
    String error = '';
    if (value.isEmpty) {
      error = AppStrings.passwordValidation;
    }
    emit(state.copyWith(passwordError: error));
  }

  /// Clears all state values back to default
  void clearState() {
    emit(state.copyWith(
      message: '',
      isFailure: false,
      isLoading: false,
      isSuccess: false,
    ));
  }

  /// Resets just the error state (after showing error toast)
  void resetError() {
    emit(state.copyWith(
      isFailure: false,
      message: '',
    ));
  }
}

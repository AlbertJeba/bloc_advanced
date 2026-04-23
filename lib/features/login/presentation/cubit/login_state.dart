import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/login/data/models/login_response.dart';

/// LoginState - Holds all the data for the login screen.
///
/// What is State?
/// - State is like a snapshot of the current situation
/// - It holds all the data the UI needs to display
/// - When state changes, the UI rebuilds to show the new data
///
/// Why use a single state class?
/// - Makes it easy to track what's happening
/// - All related data stays together
/// - Using copyWith() makes updating safe and clean
///
/// Properties:
/// - message: Error or success message
/// - usernameError: Error text for username field
/// - passwordError: Error text for password field
/// - isLoading: True when API call is in progress
/// - isFailure: True when login failed
/// - isSuccess: True when login succeeded
/// - loginData: The response from successful login
class LoginState extends Equatable {
  final String message;
  final String usernameError;
  final String passwordError;
  final bool isLoading;
  final bool isFailure;
  final bool isSuccess;
  final LoginResponse? loginData;

  /// Constructor with default values
  /// All fields start empty or false by default
  const LoginState({
    this.message = '',
    this.usernameError = '',
    this.passwordError = '',
    this.isLoading = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.loginData,
  });

  /// Creates a new state with some values changed.
  ///
  /// Example:
  /// state.copyWith(isLoading: true)
  /// This creates a new state where isLoading is true,
  /// but all other values stay the same.
  LoginState copyWith({
    String? message,
    String? usernameError,
    String? passwordError,
    bool? isLoading,
    bool? isFailure,
    bool? isSuccess,
    LoginResponse? loginData,
  }) {
    return LoginState(
      message: message ?? this.message,
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      loginData: loginData ?? this.loginData,
    );
  }

  /// Tells Equatable which fields to compare.
  /// Two states are equal if all these values are the same.
  @override
  List<Object?> get props => [
        message,
        usernameError,
        passwordError,
        isLoading,
        isFailure,
        isSuccess,
        loginData,
      ];
}

part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final String nameError;
  final String emailError;
  final String passwordError;
  final LoginResponse? registerData;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage = '',
    this.nameError = '',
    this.emailError = '',
    this.passwordError = '',
    this.registerData,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    String? nameError,
    String? emailError,
    String? passwordError,
    LoginResponse? registerData,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      registerData: registerData ?? this.registerData,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isFailure,
    errorMessage,
    nameError,
    emailError,
    passwordError,
    registerData,
  ];
}

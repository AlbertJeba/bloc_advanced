import 'dart:developer';

import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/asset_path.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/core/extension/roles.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_usecase.dart';
import 'package:bloc_advanced/features/login/presentation/cubit/login_cubit.dart';
import 'package:bloc_advanced/features/login/presentation/cubit/login_state.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_text_input.dart';
import 'package:bloc_advanced/shared/widgets/custom_toast.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Login Screen - Where users enter their username and password to sign in.
///
/// What it does:
/// 1. Shows username and password input fields
/// 2. Validates the inputs (checks if empty)
/// 3. Sends login request to the API
/// 4. If successful -> Goes to Dashboard
/// 5. If failed -> Shows error message
///
/// This screen uses BLoC pattern (LoginCubit) to manage the login state.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // The cubit that handles all login logic (validation, API calls, etc.)
  late LoginCubit _loginCubit;

  // Controllers to get text from input fields
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCubit();
  }

  /// Creates the LoginCubit with its required dependencies.
  /// We use GetIt (injector) to get the LoginUseCases.
  void _initializeCubit() {
    final loginUseCases = injector<LoginUseCases>();
    _loginCubit = LoginCubit(loginUseCases);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the cubit to all widgets below
      create: (context) => _loginCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_24),

              // BlocConsumer = Listen to state changes + Build UI based on state
              // - listener: Runs code when state changes (side effects like navigation)
              // - builder: Builds the UI based on current state
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (BuildContext context, LoginState state) {
                  // When login is successful, go to dashboard
                  if (state.isSuccess && state.loginData != null) {
                    UserPreferences.instance.setUserRole(UserRole.customer);
                    context.go(RoutesName.homePage);
                  }
                  // When login fails, show error toast
                  else if (state.isFailure && state.message.isNotEmpty) {
                    _showErrorSnackBar(context, state.message);
                    _loginCubit.resetError();
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.standard_60),

                      // Lock icon at the top
                      Center(
                        child: Container(
                          width: Dimens.standard_80,
                          height: Dimens.standard_80,
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimary.withValues(alpha: Dimens.decimal_1),
                            borderRadius: BorderRadius.circular(Dimens.standard_20),
                          ),
                          child: const Icon(
                            Icons.lock_outline_rounded,
                            size: Dimens.standard_40,
                            color: AppColors.colorPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_32),

                      // Welcome text
                      Center(
                        child: Text(
                          AppStrings.welcomeBack,
                          style: AppTextStyles.openSansBold24.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_8),

                      // Subtitle
                      Center(
                        child: Text(
                          AppStrings.signInContinue,
                          style: AppTextStyles.openSansRegular16.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_48),

                      // Username input field
                      CustomTextInput(
                        textEditingController: usernameTextController,
                        hintText: AppStrings.enterUsername,
                        title: AppStrings.username, // .tr gets the translated text
                        svgIconPath: AssetPath.emailIcon,
                        inputType: TextInputType.text,
                        onChange: (value) {
                          // Validate as user types
                          context.read<LoginCubit>().validateUsername(value);
                        },
                      ),

                      // Show error if username is invalid
                      if (state.usernameError.isNotEmpty)
                        _buildFieldValidation(state.usernameError),
                      const SizedBox(height: Dimens.standard_8),

                      // Password input field
                      CustomTextInput(
                        textEditingController: passwordTextController,
                        hintText: AppStrings.enterPassword,
                        title: AppStrings.password,
                        svgIconPath: AssetPath.eyeOpenIcon,
                        isPassword: true, // This hides the text
                        onChange: (value) {
                          context.read<LoginCubit>().validatePassword(value);
                        },
                      ),

                      // Show error if password is invalid
                      if (state.passwordError.isNotEmpty)
                        _buildFieldValidation(state.passwordError),
                      const SizedBox(height: Dimens.standard_32),

                      // Login button
                      PrimaryButton(
                        text: AppStrings.login.toUpperCase(),
                        onPressed: () {
                          context.read<LoginCubit>().validate(
                            usernameTextController.text.trim(),
                            passwordTextController.text,
                          );
                        },
                        isLoading: state.isLoading,
                      ),
                      const SizedBox(height: Dimens.standard_32),

                      // Info box with test credentials (for demo purposes)
                      Container(
                        padding: const EdgeInsets.all(Dimens.standard_16),
                        decoration: BoxDecoration(
                          color: AppColors.colorSecondary.withValues(alpha: Dimens.decimal_1),
                          borderRadius: BorderRadius.circular(Dimens.standard_12),
                          border: Border.all(
                            color: AppColors.colorSecondary.withValues(alpha: Dimens.decimal_3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: Dimens.standard_18,
                                  color: AppColors.colorSecondary,
                                ),
                                const SizedBox(width: Dimens.standard_8),
                                Text(
                                  AppStrings.testCredentials,
                                  style: AppTextStyles.openSansBold14.copyWith(
                                    color: AppColors.colorSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimens.standard_8),
                            Text(
                              AppStrings.testUserCredentials,
                              style: AppTextStyles.openSansRegular14.copyWith(
                                color: AppColors.textSecondary,
                                height: Dimens.standard_1_5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_40),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the error message widget shown below input fields
  Widget _buildFieldValidation(String errorValue) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.standard_6),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: Dimens.standard_14, color: AppColors.colorRed),
          const SizedBox(width: Dimens.standard_4),
          Text(
            errorValue,
            style: AppTextStyles.openSansRegular12.copyWith(
              color: AppColors.colorRed,
            ),
          ),
        ],
      ),
    );
  }

  /// Shows an error toast message
  void _showErrorSnackBar(BuildContext context, String message) {
    CustomToast.showErrorToast(context, message);
    log("ERROR ----- $message");
  }
}

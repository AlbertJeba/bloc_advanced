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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginCubit _loginCubit;
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCubit();
  }

  void _initializeCubit() {
    final loginUseCases = injector<LoginUseCases>();
    _loginCubit = LoginCubit(loginUseCases);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Decorative background elements
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimary.withValues(alpha: 0.05),
                ),
              ),
            ),
            
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_24),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (BuildContext context, LoginState state) {
                    if (state.isSuccess && state.loginData != null) {
                      UserPreferences.instance.setUserRole(UserRole.customer);
                      context.go(RoutesName.homePage);
                    } else if (state.isFailure && state.message.isNotEmpty) {
                      _showErrorSnackBar(context, state.message);
                      _loginCubit.resetError();
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimens.standard_40),
                        
                        // InstaMart Branding
                        Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.shopping_basket_rounded,
                                size: 80,
                                color: AppColors.colorPrimary,
                              ),
                              const SizedBox(height: Dimens.standard_16),
                              Text(
                                AppStrings.appName,
                                style: AppTextStyles.openSansBold32.copyWith(
                                  color: AppColors.colorPrimary,
                                ),
                              ),
                              Text(
                                AppStrings.appSubtitle,
                                style: AppTextStyles.openSansRegular14.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: Dimens.standard_60),
                        
                        Text(
                          AppStrings.welcomeBack,
                          style: AppTextStyles.openSansBold24.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: Dimens.standard_8),
                        Text(
                          AppStrings.signInContinue,
                          style: AppTextStyles.openSansRegular16.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        
                        const SizedBox(height: Dimens.standard_40),
                        
                        CustomTextInput(
                          textEditingController: usernameTextController,
                          hintText: AppStrings.enterUsername,
                          title: AppStrings.username,
                          svgIconPath: AssetPath.emailIcon,
                          inputType: TextInputType.text,
                          onChange: (value) {
                            context.read<LoginCubit>().validateUsername(value);
                          },
                        ),
                        if (state.usernameError.isNotEmpty)
                          _buildFieldValidation(state.usernameError),
                        const SizedBox(height: Dimens.standard_16),
                        
                        CustomTextInput(
                          textEditingController: passwordTextController,
                          hintText: AppStrings.enterPassword,
                          title: AppStrings.password,
                          svgIconPath: AssetPath.eyeOpenIcon,
                          isPassword: true,
                          onChange: (value) {
                            context.read<LoginCubit>().validatePassword(value);
                          },
                        ),
                        if (state.passwordError.isNotEmpty)
                          _buildFieldValidation(state.passwordError),
                        
                        const SizedBox(height: Dimens.standard_32),
                        
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
                        
                        // Demo Credentials Box
                        Container(
                          padding: const EdgeInsets.all(Dimens.standard_16),
                          decoration: BoxDecoration(
                            color: AppColors.appBackGround,
                            borderRadius: BorderRadius.circular(Dimens.standard_12),
                            border: Border.all(color: AppColors.colorLightGrey),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.info_outline, size: 18, color: AppColors.colorPrimary),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppStrings.testCredentials,
                                    style: AppTextStyles.openSansBold14.copyWith(color: AppColors.colorPrimary),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppStrings.testUserCredentials,
                                style: AppTextStyles.openSansRegular14.copyWith(color: AppColors.textSecondary),
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
          ],
        ),
      ),
    );
  }

  Widget _buildFieldValidation(String errorValue) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.standard_6),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 14, color: AppColors.colorRed),
          const SizedBox(width: 4),
          Text(
            errorValue,
            style: AppTextStyles.openSansRegular12.copyWith(color: AppColors.colorRed),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    CustomToast.showErrorToast(context, message);
    log("ERROR ----- $message");
  }
}

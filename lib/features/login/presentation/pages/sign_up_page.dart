import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/asset_path.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_use_case.dart';
import 'package:bloc_advanced/features/login/presentation/cubit/register_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_text_input.dart';
import 'package:bloc_advanced/shared/widgets/custom_toast.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late RegisterCubit _registerCubit;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registerCubit = RegisterCubit(injector<LoginUseCases>());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerCubit,
      child: Scaffold(
        backgroundColor: AppColors.surfaceColor,
        body: Stack(
          children: [
            // Decorative background circles
            Positioned(
              top: -Dimens.standard_50,
              right: -Dimens.standard_50,
              child: Container(
                width: Dimens.standard_200,
                height: Dimens.standard_200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorPrimaryLight.withValues(alpha: 0.15),
                ),
              ),
            ),
            Positioned(
              top: Dimens.standard_100,
              left: -Dimens.standard_60,
              child: Container(
                width: Dimens.standard_160,
                height: Dimens.standard_160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorGreen.withValues(alpha: 0.08),
                ),
              ),
            ),

            SafeArea(
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    CustomToast.showSuccessToast(
                      context,
                      AppStrings.registrationSuccess,
                    );
                    context.go(RoutesName.homePage);
                  }
                  if (state.isFailure && state.errorMessage.isNotEmpty) {
                    CustomToast.showErrorToast(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.standard_24,
                    ),
                    children: [
                      const SizedBox(height: Dimens.standard_16),

                      // Top navigation
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.textPrimary,
                              size: Dimens.standard_20,
                            ),
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(RoutesName.loginPath);
                              }
                            },
                          ),
                          const Spacer(),
                          Text(
                            AppStrings.appName,
                            style: AppTextStyles.openSansBold16.copyWith(
                              color: AppColors.colorGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.standard_24),

                      Text(
                        AppStrings.createAccount,
                        style: AppTextStyles.openSansBold28.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_8),
                      Text(
                        AppStrings.createAccountSub,
                        style: AppTextStyles.openSansRegular14.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_32),

                      // Form Inputs
                      CustomTextInput(
                        textEditingController: _nameController,
                        title: AppStrings.fullName,
                        hintText: AppStrings.enterName,
                        inputType: TextInputType.name,
                        isRequired: true,
                      ),
                      if (state.nameError.isNotEmpty)
                        _buildFieldError(state.nameError),
                      const SizedBox(height: Dimens.standard_16),

                      CustomTextInput(
                        textEditingController: _emailController,
                        title: AppStrings.emailAddress,
                        hintText: AppStrings.enterEmail,
                        svgIconPath: AssetPath.emailIcon,
                        inputType: TextInputType.emailAddress,
                        isRequired: true,
                      ),
                      if (state.emailError.isNotEmpty)
                        _buildFieldError(state.emailError),
                      const SizedBox(height: Dimens.standard_16),

                      CustomTextInput(
                        textEditingController: _phoneController,
                        title: AppStrings.phone,
                        hintText: AppStrings.enterPhone,
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(height: Dimens.standard_16),

                      CustomTextInput(
                        textEditingController: _passwordController,
                        title: AppStrings.password,
                        hintText: AppStrings.enterPassword,
                        svgIconPath: AssetPath.eyeOpenIcon,
                        isPassword: true,
                        isRequired: true,
                      ),
                      if (state.passwordError.isNotEmpty)
                        _buildFieldError(state.passwordError),
                      const SizedBox(height: Dimens.standard_32),

                      // Create Account Button
                      PrimaryButton(
                        text: AppStrings.signUp.toUpperCase(),
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
                            ? null
                            : () {
                                context
                                    .read<RegisterCubit>()
                                    .validateAndRegister(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                      password: _passwordController.text,
                                    );
                              },
                      ),
                      const SizedBox(height: Dimens.standard_24),

                      // Already have account link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAccount,
                            style: AppTextStyles.openSansRegular14.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(RoutesName.loginPath);
                              }
                            },
                            child: Text(
                              AppStrings.signIn,
                              style: AppTextStyles.openSansBold14.copyWith(
                                color: AppColors.colorGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.standard_32),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldError(String error) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.standard_6),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: Dimens.standard_14,
            color: AppColors.colorRed,
          ),
          const SizedBox(width: Dimens.standard_4),
          Text(
            error,
            style: AppTextStyles.openSansRegular12.copyWith(
              color: AppColors.colorRed,
            ),
          ),
        ],
      ),
    );
  }
}

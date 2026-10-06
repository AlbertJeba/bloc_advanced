import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';
import 'package:bloc_advanced/features/profile/domain/use_case/profile_use_case.dart';
import 'package:bloc_advanced/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:bloc_advanced/shared/widgets/custom_text_input.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit _profileCubit;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(injector<ProfileUseCase>())..fetchProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _profileCubit.close();
    super.dispose();
  }

  void _syncControllersWithUser() {
    final user = _profileCubit.state.user;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _phoneController.text = user.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileCubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.updateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.profileUpdatedSuccess),
                backgroundColor: AppColors.colorGreen,
              ),
            );
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.colorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final user = state.user;
          final isEditing = state.isEditing;

          return Scaffold(
            backgroundColor: AppColors.appBackGround,
            appBar: AppBar(
              backgroundColor: AppColors.surfaceColor,
              elevation: Dimens.standard_0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary,
                  size: Dimens.standard_20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppStrings.myProfile,
                style: AppTextStyles.openSansBold18.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            body: state.isLoading && user == null
                ? const Center(child: CustomLoader())
                : ListView(
                    padding: const EdgeInsets.all(Dimens.standard_16),
                    children: [
                      // Header Card with Avatar and Basic Name
                      _buildAvatarHeader(user),
                      const SizedBox(height: Dimens.standard_20),

                      // Content Switch: View Mode vs Edit Mode
                      if (isEditing)
                        _buildEditMode(context, state)
                      else
                        _buildViewMode(context, user),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarHeader(UserData? user) {
    final avatarUrl = user?.avatarUrl;
    final name = user?.name ?? 'Grocery Shopper';
    final email = user?.email ?? '';

    return Container(
      padding: const EdgeInsets.all(Dimens.standard_20),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_16),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        children: [
          Container(
            width: Dimens.standard_80,
            height: Dimens.standard_80,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: avatarUrl != null && avatarUrl.isNotEmpty
                ? CustomNetworkImage(
                    imageUrl: avatarUrl,
                    width: Dimens.standard_80,
                    height: Dimens.standard_80,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: AppColors.colorGreen.withValues(alpha: 0.15),
                    child: Center(
                      child: Text(
                        (name.isNotEmpty ? name[0] : 'U').toUpperCase(),
                        style: AppTextStyles.openSansBold30.copyWith(
                          color: AppColors.colorGreen,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: Dimens.standard_12),
          Text(
            name,
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (email.isNotEmpty) ...[
            const SizedBox(height: Dimens.standard_4),
            Text(
              email,
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildViewMode(BuildContext context, UserData? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information Card
        _buildSectionHeader(AppStrings.personalInformation),
        const SizedBox(height: Dimens.standard_8),
        Container(
          padding: const EdgeInsets.all(Dimens.standard_16),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(Dimens.standard_16),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                icon: Icons.person_outline_rounded,
                label: AppStrings.fullName,
                value: user?.name?.isNotEmpty == true ? user!.name! : '—',
              ),
              const Divider(
                height: Dimens.standard_24,
                color: AppColors.dividerColor,
              ),
              _buildDetailRow(
                icon: Icons.email_outlined,
                label: AppStrings.emailAddress,
                value: user?.email?.isNotEmpty == true ? user!.email! : '—',
                trailingBadge: AppStrings.verified,
              ),
              const Divider(
                height: Dimens.standard_24,
                color: AppColors.dividerColor,
              ),
              _buildDetailRow(
                icon: Icons.phone_outlined,
                label: AppStrings.phone,
                value: user?.phone?.isNotEmpty == true
                    ? '+91 ${user!.phone!}'
                    : '—',
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.standard_28),

        // Edit Profile Button
        PrimaryButton(
          text: AppStrings.editProfile,
          prefixIcon: const Icon(
            Icons.edit,
            color: AppColors.colorWhite,
            size: Dimens.standard_18,
          ),
          onPressed: () {
            _syncControllersWithUser();
            _profileCubit.toggleEditMode(true);
          },
        ),
      ],
    );
  }

  Widget _buildEditMode(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(AppStrings.editProfile),
        const SizedBox(height: Dimens.standard_12),

        Container(
          padding: const EdgeInsets.all(Dimens.standard_16),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(Dimens.standard_16),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInput(
                title: AppStrings.fullName,
                hintText: AppStrings.enterName,
                textEditingController: _nameController,
                isRequired: true,
              ),
              const SizedBox(height: Dimens.standard_16),
              CustomTextInput(
                title: AppStrings.phoneNumber,
                hintText: AppStrings.enterPhone,
                textEditingController: _phoneController,
                inputType: TextInputType.phone,
                isRequired: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.standard_24),

        // Action Buttons
        PrimaryButton(
          text: AppStrings.saveChanges,
          isLoading: state.isUpdating,
          onPressed: state.isUpdating
              ? null
              : () {
                  final name = _nameController.text.trim();
                  final phone = _phoneController.text.trim();

                  _profileCubit.updateProfile(
                    UpdateProfileRequest(name: name, phone: phone),
                  );
                },
        ),
        const SizedBox(height: Dimens.standard_12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => _profileCubit.toggleEditMode(false),
            child: Text(
              AppStrings.cancel,
              style: AppTextStyles.openSansBold14.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.openSansBold16.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    String? trailingBadge,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Dimens.standard_36,
          height: Dimens.standard_36,
          decoration: BoxDecoration(
            color: AppColors.colorGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimens.standard_8),
          ),
          child: Icon(
            icon,
            color: AppColors.colorGreen,
            size: Dimens.standard_20,
          ),
        ),
        const SizedBox(width: Dimens.standard_14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.openSansRegular12.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: Dimens.standard_2),
              Text(
                value,
                style: AppTextStyles.openSansBold14.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (trailingBadge != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.standard_8,
              vertical: Dimens.standard_4,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Dimens.standard_6),
            ),
            child: Text(
              trailingBadge,
              style: AppTextStyles.openSansBold10.copyWith(
                color: AppColors.colorGreen,
              ),
            ),
          ),
      ],
    );
  }
}

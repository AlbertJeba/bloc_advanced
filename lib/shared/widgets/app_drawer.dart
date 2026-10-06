import 'package:bloc_advanced/core/constants/app_language.dart';
import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/network/logout_service_function.dart';
import 'package:bloc_advanced/core/services/share_service.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.instance.getUser();

    return Drawer(
      backgroundColor: AppColors.surfaceColor,
      child: SafeArea(
        child: Column(
          children: [
            // User Header
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                context.push(RoutesName.profile);
              },
              child: Container(
                padding: const EdgeInsets.all(Dimens.standard_20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.dividerColor),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Dimens.standard_54,
                      height: Dimens.standard_54,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: user?.avatarUrl?.isNotEmpty == true
                          ? CustomNetworkImage(
                              imageUrl: user!.avatarUrl!,
                              width: Dimens.standard_54,
                              height: Dimens.standard_54,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: AppColors.colorGreen.withValues(
                                alpha: 0.15,
                              ),
                              child: Center(
                                child: Text(
                                  (user?.name?.isNotEmpty == true
                                          ? user!.name![0]
                                          : 'U')
                                      .toUpperCase(),
                                  style: AppTextStyles.openSansBold20.copyWith(
                                    color: AppColors.colorGreen,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: Dimens.standard_16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name?.isNotEmpty == true
                                ? user!.name!
                                : 'Grocery Shopper',
                            style: AppTextStyles.openSansBold16.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: Dimens.standard_4),
                          Text(
                            user?.email?.isNotEmpty == true ? user!.email! : '',
                            style: AppTextStyles.openSansRegular12.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: Dimens.standard_14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.standard_12,
                ),
                children: [
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.home_rounded,
                    title: AppStrings.welcome,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.receipt_long_rounded,
                    title: AppStrings.myOrders,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(RoutesName.orders);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.favorite_rounded,
                    title: AppStrings.myWishlist,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(RoutesName.wishlist);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.shopping_bag_rounded,
                    title: AppStrings.myCart,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(RoutesName.cart);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.person_rounded,
                    title: AppStrings.myProfile,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(RoutesName.profile);
                    },
                  ),
                  const Divider(
                    color: AppColors.dividerColor,
                    height: Dimens.standard_24,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.translate_rounded,
                    title: AppStrings.changeLanguage,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.standard_8,
                        vertical: Dimens.standard_2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Dimens.standard_6),
                      ),
                      child: Text(
                        _getCurrentLanguageLabel(),
                        style: AppTextStyles.openSansBold10.copyWith(
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showLanguageBottomSheet(context);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.share_rounded,
                    title: AppStrings.shareApp,
                    onTap: () {
                      Navigator.of(context).pop();
                      ShareService.shareText(
                        '${AppStrings.shareAppMessage} ${EnvInfo.appName}',
                      );
                    },
                  ),
                ],
              ),
            ),

            // Bottom Section (Logout & Version)
            Container(
              padding: const EdgeInsets.all(Dimens.standard_16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.dividerColor)),
              ),
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: Dimens.standard_36,
                        height: Dimens.standard_36,
                        decoration: BoxDecoration(
                          color: AppColors.colorRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            Dimens.standard_8,
                          ),
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: AppColors.colorRed,
                          size: Dimens.standard_20,
                        ),
                      ),
                      title: Text(
                        AppStrings.logout,
                        style: AppTextStyles.openSansBold14.copyWith(
                          color: AppColors.colorRed,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showLogoutDialog(context);
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.standard_8),
                  Text(
                    '${EnvInfo.appName} • ${AppStrings.appVersion}',
                    style: AppTextStyles.openSansRegular10.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentLanguageLabel() {
    final code = Get.locale?.languageCode ?? 'en';
    switch (code) {
      case 'ta':
        return 'தமிழ்';
      case 'hi':
        return 'हिन्दी';
      default:
        return 'English';
    }
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.textPrimary,
          size: Dimens.standard_22,
        ),
        title: Text(
          title,
          style: AppTextStyles.openSansBold14.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.standard_20),
        ),
      ),
      builder: (bottomSheetContext) {
        final currentCode = Get.locale?.languageCode ?? 'en';

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.standard_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: Dimens.standard_40,
                    height: Dimens.standard_4,
                    decoration: BoxDecoration(
                      color: AppColors.colorLightGrey,
                      borderRadius: BorderRadius.circular(Dimens.standard_2),
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.standard_16),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.standard_20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.selectLanguage,
                        style: AppTextStyles.openSansBold18.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: Dimens.standard_4),
                      Text(
                        AppStrings.chooseLanguageSub,
                        style: AppTextStyles.openSansRegular12.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.standard_12),
                const Divider(color: AppColors.dividerColor),

                ...AppLanguage.supportedLanguages.map((lang) {
                  final isSelected = currentCode == lang.code;

                  return Material(
                    color: isSelected
                        ? AppColors.colorPrimary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimens.standard_20,
                      ),
                      title: Text(
                        lang.nativeName,
                        style: AppTextStyles.openSansBold16.copyWith(
                          color: isSelected
                              ? AppColors.colorPrimary
                              : AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        lang.name,
                        style: AppTextStyles.openSansRegular12.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.colorPrimary,
                              size: Dimens.standard_22,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: AppColors.colorLightGrey,
                              size: Dimens.standard_22,
                            ),
                      onTap: () async {
                        Navigator.of(bottomSheetContext).pop();
                        await AppLanguage.changeLanguage(lang.code);
                      },
                    ),
                  );
                }),
                const SizedBox(height: Dimens.standard_8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.standard_16),
          ),
          title: Text(
            AppStrings.logout,
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            AppStrings.confirmLogout,
            style: AppTextStyles.openSansRegular14.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.openSansBold14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorRed,
                elevation: Dimens.standard_0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_8),
                ),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await LogoutService.instance.logoutAndNavigate();
              },
              child: Text(
                AppStrings.yesLogout,
                style: AppTextStyles.openSansBold14.copyWith(
                  color: AppColors.colorWhite,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

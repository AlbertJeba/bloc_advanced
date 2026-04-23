import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// CustomToast - Reusable Toast Notification Utility
/// 
/// Provides static methods to show styled toast notifications
/// using the toastification package.
/// 
/// Toast Types:
/// - [showErrorToast] - Red error notification
/// - [showSuccessToast] - Green success notification
/// - [showInfoToast] - Blue info notification
/// - [showWarningToast] - Yellow warning notification
/// 
/// All toasts:
/// - Auto-dismiss after 3 seconds
/// - Appear at the bottom center
/// - Use minimal styling
/// - Support localized titles via GetX `.tr`
/// 
/// Usage:
/// ```dart
/// CustomToast.showSuccessToast(context, 'Operation completed!');
/// CustomToast.showErrorToast(context, 'Something went wrong');
/// ```
class CustomToast {
  /// Shows an error toast with red styling.
  /// 
  /// [context] - BuildContext for showing the toast
  /// [message] - The message to display
  static void showErrorToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(AppStrings.error, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Shows a success toast with green styling.
  /// 
  /// [context] - BuildContext for showing the toast
  /// [message] - The message to display
  static void showSuccessToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(AppStrings.success, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Shows an info toast with blue/primary styling.
  /// 
  /// [context] - BuildContext for showing the toast
  /// [message] - The message to display
  static void showInfoToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(AppStrings.info, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      primaryColor: AppColors.colorPrimary,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Shows a warning toast with yellow/orange styling.
  /// 
  /// [context] - BuildContext for showing the toast
  /// [message] - The message to display
  static void showWarningToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(AppStrings.warning, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }
}


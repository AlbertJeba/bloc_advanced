import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

/// AppTheme - Application Theme Configuration
/// 
/// Provides the app's ThemeData with customized styling for:
/// - Color scheme (primary, secondary, surface colors)
/// - Typography (text styles using OpenSans font)
/// - Button themes (elevated, outlined, text buttons)
/// - Input decoration (text fields)
/// - Card, divider, icon themes
/// - Snackbar and navigation bar themes
/// 
/// Usage:
/// ```dart
/// MaterialApp(theme: AppTheme.lightTheme)
/// ```
class AppTheme {
  /// Returns the light theme configuration.
  /// 
  /// Uses Material 3 design with custom color scheme from [AppColors]
  /// and typography from [AppTextStyles].
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.colorPrimary,
        onPrimary: AppColors.colorWhite,
        secondary: AppColors.colorSecondary,
        onSecondary: AppColors.colorWhite,
        surface: AppColors.surfaceColor,
        onSurface: AppColors.textPrimary,
        error: AppColors.colorRed,
        onError: AppColors.colorWhite,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.appBackGround,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: Dimens.standard_0,
        centerTitle: true,
        backgroundColor: AppColors.colorPrimary,
        foregroundColor: AppColors.colorWhite,
        titleTextStyle: AppTextStyles.openSansBold18.copyWith(
          color: AppColors.colorWhite,
        ),
        iconTheme: const IconThemeData(color: AppColors.colorWhite),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.openSansBold32.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.openSansBold24.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.openSansBold20.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.openSansBold20.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTextStyles.openSansBold18.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.openSansSemiBold16.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyles.openSansRegular16.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTextStyles.openSansSemiBold16.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: Dimens.standard_0,
          backgroundColor: AppColors.colorPrimary,
          foregroundColor: AppColors.colorWhite,
          minimumSize: const Size(double.infinity, Dimens.standard_52),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_24, vertical: Dimens.standard_14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.standard_12),
          ),
          textStyle: AppTextStyles.openSansBold16,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.colorPrimary,
          minimumSize: const Size(double.infinity, Dimens.standard_52),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_24, vertical: Dimens.standard_14),
          side: const BorderSide(color: AppColors.colorPrimary, width: Dimens.standard_1_5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.standard_12),
          ),
          textStyle: AppTextStyles.openSansBold16,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.colorPrimary,
          textStyle: AppTextStyles.openSansBold14,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.standard_16, vertical: Dimens.standard_16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: Dimens.standard_1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: const BorderSide(color: AppColors.inputFocusBorder, width: Dimens.standard_2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: const BorderSide(color: AppColors.colorRed, width: Dimens.standard_1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          borderSide: const BorderSide(color: AppColors.colorRed, width: Dimens.standard_2),
        ),
        hintStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textLight,
        ),
        labelStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        elevation: Dimens.standard_2,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.standard_16)),
        ),
        color: AppColors.cardBackground,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: Dimens.standard_1,
        space: Dimens.standard_1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: Dimens.standard_24,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.colorPrimary,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.colorWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.standard_8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.colorWhite,
        selectedItemColor: AppColors.colorPrimary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: Dimens.standard_8,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.colorPrimary,
        foregroundColor: AppColors.colorWhite,
        elevation: Dimens.standard_4,
      ),
    );
  }
}

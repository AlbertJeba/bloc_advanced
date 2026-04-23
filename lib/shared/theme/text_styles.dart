import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:flutter/material.dart';

/// AppTextStyles - Predefined Text Style Constants
/// 
/// Provides consistent typography across the application using
/// the OpenSans font family.
/// 
/// Naming Convention: `openSans{Weight}{Size}`
/// - Weight: Regular, SemiBold, Bold
/// - Size: Font size in pixels (10, 12, 14, 16, 18, 20, 24, 32, 40, 44)
/// 
/// Usage:
/// ```dart
/// Text('Hello', style: AppTextStyles.openSansBold16)
/// Text('Subtitle', style: AppTextStyles.openSansRegular14.copyWith(color: Colors.grey))
/// ```
class AppTextStyles {
  /// The font family used throughout the app.
  static const String fontFamily = 'OpenSans';

  static TextStyle openSansSemiBold16 = const TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular14w400 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular12w300 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular10w300 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );

  /// Text style for heading

  static const TextStyle openSansBold44 = TextStyle(
    fontSize: Dimens.standard_44,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold40 = TextStyle(
    fontSize: Dimens.standard_40,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold32 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold24 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold20 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold18 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular12 = TextStyle(
    fontSize: Dimens.standard_12,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular14 = TextStyle(
    fontSize: Dimens.standard_14,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular16 = TextStyle(
    fontSize: Dimens.standard_16,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansRegular18 = TextStyle(
    fontSize: Dimens.standard_18,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold12 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold13 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold14 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static const TextStyle openSansBold16 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
}

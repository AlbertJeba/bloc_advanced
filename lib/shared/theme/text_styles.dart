import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:flutter/material.dart';

/// AppTextStyles - Optimized Predefined Typography Constants
///
/// Provides sizes 10 to 32 across weights w300 to w900 in a compact, const-optimized structure.
class AppTextStyles {
  static const String fontFamily = 'OpenSans';

  /// Flexible builder helper for dynamic font styling.
  static TextStyle openSans({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    fontFamily: fontFamily,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    decoration: decoration,
  );

  // Size 10
  static const TextStyle openSans10w300 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w400 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w500 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w600 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w700 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w800 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans10w900 = TextStyle(
    fontSize: Dimens.standard_10,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular10 = openSans10w400;
  static const TextStyle openSansMedium10 = openSans10w500;
  static const TextStyle openSansSemiBold10 = openSans10w600;
  static const TextStyle openSansBold10 = openSans10w700;

  // Size 11
  static const TextStyle openSans11w300 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w400 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w500 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w600 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w700 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w800 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans11w900 = TextStyle(
    fontSize: Dimens.standard_11,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular11 = openSans11w400;
  static const TextStyle openSansMedium11 = openSans11w500;
  static const TextStyle openSansSemiBold11 = openSans11w600;
  static const TextStyle openSansBold11 = openSans11w700;

  // Size 12
  static const TextStyle openSans12w300 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w400 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w500 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w600 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w700 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w800 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans12w900 = TextStyle(
    fontSize: Dimens.standard_12,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular12 = openSans12w400;
  static const TextStyle openSansMedium12 = openSans12w500;
  static const TextStyle openSansSemiBold12 = openSans12w600;
  static const TextStyle openSansBold12 = openSans12w700;

  // Size 13
  static const TextStyle openSans13w300 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w400 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w500 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w600 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w700 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w800 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans13w900 = TextStyle(
    fontSize: Dimens.standard_13,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular13 = openSans13w400;
  static const TextStyle openSansMedium13 = openSans13w500;
  static const TextStyle openSansSemiBold13 = openSans13w600;
  static const TextStyle openSansBold13 = openSans13w700;

  // Size 14
  static const TextStyle openSans14w300 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w400 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w500 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w600 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w700 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w800 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans14w900 = TextStyle(
    fontSize: Dimens.standard_14,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular14 = openSans14w400;
  static const TextStyle openSansMedium14 = openSans14w500;
  static const TextStyle openSansSemiBold14 = openSans14w600;
  static const TextStyle openSansBold14 = openSans14w700;

  // Size 15
  static const TextStyle openSans15w300 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w400 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w500 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w600 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w700 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w800 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans15w900 = TextStyle(
    fontSize: Dimens.standard_15,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular15 = openSans15w400;
  static const TextStyle openSansMedium15 = openSans15w500;
  static const TextStyle openSansSemiBold15 = openSans15w600;
  static const TextStyle openSansBold15 = openSans15w700;

  // Size 16
  static const TextStyle openSans16w300 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w400 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w500 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w600 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w700 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w800 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans16w900 = TextStyle(
    fontSize: Dimens.standard_16,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular16 = openSans16w400;
  static const TextStyle openSansMedium16 = openSans16w500;
  static const TextStyle openSansSemiBold16 = openSans16w600;
  static const TextStyle openSansBold16 = openSans16w700;

  // Size 17
  static const TextStyle openSans17w300 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w400 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w500 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w600 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w700 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w800 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans17w900 = TextStyle(
    fontSize: Dimens.standard_17,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular17 = openSans17w400;
  static const TextStyle openSansMedium17 = openSans17w500;
  static const TextStyle openSansSemiBold17 = openSans17w600;
  static const TextStyle openSansBold17 = openSans17w700;

  // Size 18
  static const TextStyle openSans18w300 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w400 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w500 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w600 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w700 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w800 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans18w900 = TextStyle(
    fontSize: Dimens.standard_18,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular18 = openSans18w400;
  static const TextStyle openSansMedium18 = openSans18w500;
  static const TextStyle openSansSemiBold18 = openSans18w600;
  static const TextStyle openSansBold18 = openSans18w700;

  // Size 19
  static const TextStyle openSans19w300 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w400 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w500 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w600 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w700 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w800 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans19w900 = TextStyle(
    fontSize: Dimens.standard_19,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular19 = openSans19w400;
  static const TextStyle openSansMedium19 = openSans19w500;
  static const TextStyle openSansSemiBold19 = openSans19w600;
  static const TextStyle openSansBold19 = openSans19w700;

  // Size 20
  static const TextStyle openSans20w300 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w400 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w500 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w600 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w700 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w800 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans20w900 = TextStyle(
    fontSize: Dimens.standard_20,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular20 = openSans20w400;
  static const TextStyle openSansMedium20 = openSans20w500;
  static const TextStyle openSansSemiBold20 = openSans20w600;
  static const TextStyle openSansBold20 = openSans20w700;

  // Size 21
  static const TextStyle openSans21w300 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w400 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w500 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w600 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w700 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w800 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans21w900 = TextStyle(
    fontSize: Dimens.standard_21,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular21 = openSans21w400;
  static const TextStyle openSansMedium21 = openSans21w500;
  static const TextStyle openSansSemiBold21 = openSans21w600;
  static const TextStyle openSansBold21 = openSans21w700;

  // Size 22
  static const TextStyle openSans22w300 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w400 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w500 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w600 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w700 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w800 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans22w900 = TextStyle(
    fontSize: Dimens.standard_22,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular22 = openSans22w400;
  static const TextStyle openSansMedium22 = openSans22w500;
  static const TextStyle openSansSemiBold22 = openSans22w600;
  static const TextStyle openSansBold22 = openSans22w700;

  // Size 23
  static const TextStyle openSans23w300 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w400 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w500 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w600 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w700 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w800 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans23w900 = TextStyle(
    fontSize: Dimens.standard_23,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular23 = openSans23w400;
  static const TextStyle openSansMedium23 = openSans23w500;
  static const TextStyle openSansSemiBold23 = openSans23w600;
  static const TextStyle openSansBold23 = openSans23w700;

  // Size 24
  static const TextStyle openSans24w300 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w400 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w500 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w600 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w700 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w800 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans24w900 = TextStyle(
    fontSize: Dimens.standard_24,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular24 = openSans24w400;
  static const TextStyle openSansMedium24 = openSans24w500;
  static const TextStyle openSansSemiBold24 = openSans24w600;
  static const TextStyle openSansBold24 = openSans24w700;

  // Size 25
  static const TextStyle openSans25w300 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w400 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w500 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w600 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w700 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w800 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans25w900 = TextStyle(
    fontSize: Dimens.standard_25,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular25 = openSans25w400;
  static const TextStyle openSansMedium25 = openSans25w500;
  static const TextStyle openSansSemiBold25 = openSans25w600;
  static const TextStyle openSansBold25 = openSans25w700;

  // Size 26
  static const TextStyle openSans26w300 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w400 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w500 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w600 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w700 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w800 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans26w900 = TextStyle(
    fontSize: Dimens.standard_26,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular26 = openSans26w400;
  static const TextStyle openSansMedium26 = openSans26w500;
  static const TextStyle openSansSemiBold26 = openSans26w600;
  static const TextStyle openSansBold26 = openSans26w700;

  // Size 27
  static const TextStyle openSans27w300 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w400 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w500 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w600 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w700 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w800 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans27w900 = TextStyle(
    fontSize: Dimens.standard_27,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular27 = openSans27w400;
  static const TextStyle openSansMedium27 = openSans27w500;
  static const TextStyle openSansSemiBold27 = openSans27w600;
  static const TextStyle openSansBold27 = openSans27w700;

  // Size 28
  static const TextStyle openSans28w300 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w400 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w500 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w600 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w700 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w800 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans28w900 = TextStyle(
    fontSize: Dimens.standard_28,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular28 = openSans28w400;
  static const TextStyle openSansMedium28 = openSans28w500;
  static const TextStyle openSansSemiBold28 = openSans28w600;
  static const TextStyle openSansBold28 = openSans28w700;

  // Size 29
  static const TextStyle openSans29w300 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w400 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w500 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w600 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w700 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w800 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans29w900 = TextStyle(
    fontSize: Dimens.standard_29,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular29 = openSans29w400;
  static const TextStyle openSansMedium29 = openSans29w500;
  static const TextStyle openSansSemiBold29 = openSans29w600;
  static const TextStyle openSansBold29 = openSans29w700;

  // Size 30
  static const TextStyle openSans30w300 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w400 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w500 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w600 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w700 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w800 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans30w900 = TextStyle(
    fontSize: Dimens.standard_30,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular30 = openSans30w400;
  static const TextStyle openSansMedium30 = openSans30w500;
  static const TextStyle openSansSemiBold30 = openSans30w600;
  static const TextStyle openSansBold30 = openSans30w700;

  // Size 31
  static const TextStyle openSans31w300 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w400 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w500 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w600 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w700 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w800 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans31w900 = TextStyle(
    fontSize: Dimens.standard_31,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular31 = openSans31w400;
  static const TextStyle openSansMedium31 = openSans31w500;
  static const TextStyle openSansSemiBold31 = openSans31w600;
  static const TextStyle openSansBold31 = openSans31w700;

  // Size 32
  static const TextStyle openSans32w300 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w300,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w400 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w500 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w600 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w700 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w800 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w800,
    fontFamily: fontFamily,
  );
  static const TextStyle openSans32w900 = TextStyle(
    fontSize: Dimens.standard_32,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansRegular32 = openSans32w400;
  static const TextStyle openSansMedium32 = openSans32w500;
  static const TextStyle openSansSemiBold32 = openSans32w600;
  static const TextStyle openSansBold32 = openSans32w700;

  // Heading Sizes 40 & 44
  static const TextStyle openSansBold40 = TextStyle(
    fontSize: Dimens.standard_40,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const TextStyle openSansBold44 = TextStyle(
    fontSize: Dimens.standard_44,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
}

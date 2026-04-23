import 'package:flutter/material.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';

/// PrimaryButton - Reusable Styled Button Widget
/// 
/// A primary actionable button with support for gradients, loading states,
/// outlined styles, and custom icons.
/// 
/// Features:
/// - Gradient background support
/// - Loading state with [CustomLoader]
/// - Outlined and solid styles
/// - Prefix and Suffix icon support
/// - Consistent elevation and splash effects
/// 
/// Usage:
/// ```dart
/// PrimaryButton(
///   text: 'Login',
///   onPressed: () => print('Login pressed'),
///   isLoading: state.isLoading,
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final List<Color>? gradientColors;
  final double borderRadius;
  final bool isOutlined;
  final bool enabled;
  final Color? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = Dimens.standard_52,
    this.gradientColors,
    this.borderRadius = Dimens.standard_16,
    this.isOutlined = false,
    this.enabled = true,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Visual state is strictly driven by the 'enabled' param
    final bool isVisuallyEnabled = enabled;
    // Interaction logic
    final bool isClickable = !isLoading && onPressed != null && enabled;

    final Color textColor = isOutlined
        ? (isVisuallyEnabled
            ? (color ?? AppColors.colorPrimary)
            : AppColors.buttonDisabledColor)
        : AppColors.colorWhite;

    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: isOutlined
            ? BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isVisuallyEnabled
                      ? (color ?? AppColors.colorPrimary)
                      : AppColors.buttonDisabledColor,
                  width: Dimens.standard_1_5,
                ),
              )
            : BoxDecoration(
                gradient: isVisuallyEnabled && color == null
                    ? LinearGradient(
                        colors: gradientColors ??
                            [
                              AppColors.buttonGradientStart,
                              AppColors.colorPrimary,
                            ],
                      )
                    : null,
                color: isVisuallyEnabled ? color : AppColors.buttonDisabledColor,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: isVisuallyEnabled && !isOutlined
                    ? [
                        BoxShadow(
                          color: (color ?? AppColors.colorPrimary).withValues(alpha: 0.3),
                          blurRadius: Dimens.standard_8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isClickable ? onPressed : null,
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: AppColors.colorWhite.withValues(alpha: 0.1),
            highlightColor: AppColors.colorWhite.withValues(alpha: 0.05),
            child: IconTheme(
              data: IconThemeData(
                color: textColor,
                size: Dimens.standard_20,
              ),
              child: Center(
                child: isLoading
                    ? CustomLoader(
                        size: Dimens.standard_24,
                        strokeWidth: Dimens.standard_2_5,
                        color: textColor,
                        isCentered: false,
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (prefixIcon != null) ...[
                            prefixIcon!,
                            SizedBox(width: Dimens.standard_8),
                          ],
                          Text(
                            text,
                            style: (textStyle ?? AppTextStyles.openSansBold16).copyWith(
                              color: textColor,
                              height: 1.0,
                            ),
                          ),
                          if (suffixIcon != null) ...[
                            SizedBox(width: Dimens.standard_8),
                            suffixIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

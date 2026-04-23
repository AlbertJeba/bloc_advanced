import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// CustomLoader - Reusable Loading Indicator Widget
/// 
/// A flexible themed progress indicator used throughout the app.
/// 
/// Features:
/// - Supports adaptive styling (Material/Cupertino)
/// - Customizable size, color, and stroke width
/// - Centered by default
/// 
/// Usage:
/// ```dart
/// const CustomLoader() // Default center primary loader
/// const CustomLoader(color: Colors.white, size: 24) // Small white loader for buttons
/// ```
class CustomLoader extends StatelessWidget {
  final Color? color;
  final double? size;
  final double strokeWidth;
  final bool isCentered;

  /// Creates a custom loader widget.
  const CustomLoader({
    super.key,
    this.color,
    this.size,
    this.strokeWidth = Dimens.standard_4,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget loader = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color ?? AppColors.colorPrimary),
      ),
    );

    if (isCentered) {
      return Center(child: loader);
    }
    return loader;
  }
}

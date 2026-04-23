import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';

/// CustomNetworkImage - A wrapper around CachedNetworkImage
/// 
/// This widget provides a consistent way to display network images with 
/// automatic caching, loading placeholders, and error handling.
/// 
/// Supports:
/// - Custom border radius (ClipRRect)
/// - Custom fit and dimensions
/// - Integration with [CustomLoader] for progress states
/// - Consistent error UI
class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? placeholderSize;
  final Color? backgroundColor;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _buildErrorWidget();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        // Shows while image is fetching
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: backgroundColor ?? AppColors.inputBackground,
          child: Center(
            child: CustomLoader(
              size: placeholderSize ?? Dimens.standard_24,
              strokeWidth: Dimens.standard_2,
            ),
          ),
        ),
        // Shows if image loading fails
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? AppColors.inputBackground,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: placeholderSize ?? Dimens.standard_32,
          color: AppColors.textLight,
        ),
      ),
    );
  }
}

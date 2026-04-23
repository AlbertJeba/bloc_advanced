import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// getSvg - SVG Image Loader Utility
/// 
/// A flexible helper function to load SVG images from various sources
/// with customizable styling options.
/// 
/// Supports:
/// - Local assets (`assets/icons/icon.svg`)
/// - Network URLs (when [isNetwork] is true)
/// - Package assets (`package_name:assets/icon.svg`)
/// 
/// Parameters:
/// - [iconPath] - Path to the SVG (asset path, URL, or package:path)
/// - [width] - Optional fixed width
/// - [height] - Optional fixed height
/// - [color] - Optional color tint (uses srcIn blend mode)
/// - [boxFit] - How to fit the SVG (default: BoxFit.contain)
/// - [alignment] - Alignment within bounds (default: center)
/// - [isNetwork] - Set true for network URLs
/// 
/// Usage:
/// ```dart
/// getSvg(AssetPath.homeIcon, color: Colors.blue)
/// getSvg('https://example.com/icon.svg', isNetwork: true)
/// ```
SvgPicture getSvg(
  String iconPath, {
  double? width,
  double? height,
  Color? color,
  BoxFit? boxFit,
  AlignmentGeometry? alignment,
  bool isNetwork = false,
}) {
  List<String> list = iconPath.split(':');

  // Apply color filter if color is provided
  ColorFilter? colorFilter =
      color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null;

  // Handle network SVGs
  if (isNetwork) {
    return SvgPicture.network(
      iconPath,
      width: width,
      height: height,
      colorFilter: colorFilter,
      fit: boxFit ?? BoxFit.contain,
    );
  }

  // Handle package assets (format: "package_name:asset_path")
  if (list.length > 1) {
    return SvgPicture.asset(
      list[1],
      package: list[0],
      width: width,
      height: height,
      colorFilter: colorFilter,
      alignment: alignment ?? Alignment.center,
      fit: boxFit ?? BoxFit.contain,
    );
  }

  // Handle local assets
  return SvgPicture.asset(
    list.first,
    width: width,
    height: height,
    colorFilter: colorFilter,
    fit: boxFit ?? BoxFit.contain,
  );
}


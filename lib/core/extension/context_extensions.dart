import 'package:flutter/material.dart';

/// ContextExtensions
///
/// Extension methods on [BuildContext] to simplify access to screen metrics,
/// safe area insets (notches, dynamic islands, navigation bars), keyboard state,
/// and design tokens.
extension ContextExtensions on BuildContext {
  /// MediaQuery Data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen Dimensions
  Size get screenSize => mediaQuery.size;

  double get screenHeight => screenSize.height;

  double get screenWidth => screenSize.width;

  /// Safe Area Insets & Padding
  EdgeInsets get mediaPadding => mediaQuery.padding;

  double get topPadding => mediaPadding.top;

  double get bottomPadding => mediaPadding.bottom;

  double get leftPadding => mediaPadding.left;

  double get rightPadding => mediaPadding.right;

  /// Keyboard / View Insets
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  double get keyboardHeight => viewInsets.bottom;

  bool get isKeyboardOpen => keyboardHeight > 0;

  /// Theme & Typography Shortcuts
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  /// Standard Form / Auth Scroll Padding
  ///
  /// Automatically accounts for the status bar / notch at the top
  /// and the virtual home bar / navigation bar at the bottom.
  EdgeInsets get authScreenPadding =>
      EdgeInsets.fromLTRB(20, topPadding + 16, 20, bottomPadding + 32);

  /// Dynamic Edge-to-Edge Scroll Padding helper
  EdgeInsets authScrollPadding({
    double horizontal = 20,
    double topExtra = 16,
    double bottomExtra = 32,
  }) => EdgeInsets.fromLTRB(
    horizontal,
    topPadding + topExtra,
    horizontal,
    bottomPadding + bottomExtra,
  );
}

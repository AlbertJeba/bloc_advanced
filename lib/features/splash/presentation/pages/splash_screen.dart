import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/asset_path.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Splash Screen - The first screen users see when they open the app.
///
/// What it does:
/// 1. Shows the app logo with a nice animation
/// 2. Checks if the user is already logged in
/// 3. If logged in -> Goes to Dashboard
/// 4. If not logged in -> Goes to Login page
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // This controls how our animations work (start, stop, duration)
  late AnimationController _animationController;

  // This makes things appear slowly (fade in effect)
  late Animation<double> _fadeAnimation;

  // This makes things grow from small to big (zoom effect)
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Set up the animations when screen loads
    _setupAnimations();
    // Check if user is logged in and navigate
    _checkAuthAndNavigate();
  }

  /// Sets up the fade and scale animations
  void _setupAnimations() {
    // Animation will run for 1.5 seconds
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Fade: Goes from invisible (0) to fully visible (1)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Scale: Goes from 80% size to 100% size with a bounce
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    // Clean up: Always dispose animation controllers to prevent memory leaks
    _animationController.dispose();
    super.dispose();
  }

  /// Checks if user is logged in and goes to the right screen
  ///
  /// How it works:
  /// 1. Wait 2 seconds (so user can see the splash)
  /// 2. Look for saved login token in storage (Hive)
  /// 3. If token exists -> User is logged in -> Go to Dashboard
  /// 4. If no token -> User needs to login -> Go to Login page
  Future<void> _checkAuthAndNavigate() async {
    // Wait 2 seconds for the splash animation
    await Future.delayed(const Duration(seconds: 2));

    // Safety check: Make sure screen is still visible
    if (!mounted) return;

    // Get the storage service to check for saved token
    final hiveService = GetIt.instance<HiveService>();
    final token = await hiveService.get(userToken);

    // Check if we have a valid token
    if (token != null && token.toString().isNotEmpty) {
      // User is logged in! Add token to network requests
      final networkService = GetIt.instance<NetworkService>();
      networkService.updateHeader({'Authorization': 'Bearer $token'});

      // Go to Dashboard
      if (mounted) {
        context.go(RoutesName.homePage);
      }
    } else {
      // No token found, user needs to login
      if (mounted) {
        context.go(RoutesName.loginPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient background: Blue color that goes from light to dark
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.colorPrimary, AppColors.colorPrimaryDark],
          ),
        ),
        child: SafeArea(
          child: Center(
            // AnimatedBuilder rebuilds the widget when animation changes
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Logo in a rounded container
                        Container(
                          width: Dimens.standard_120,
                          height: Dimens.standard_120,
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite.withValues(
                              alpha: Dimens.decimal_8,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimens.standard_30,
                            ),
                          ),
                          child: Center(
                            child: getSvg(
                              AssetPath.splashIcon,
                              width: Dimens.standard_80,
                              height: Dimens.standard_80,
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimens.standard_32),

                        // App name text
                        Text(
                          AppStrings.appName,
                          style: AppTextStyles.openSansBold32.copyWith(
                            color: AppColors.colorWhite,
                            letterSpacing: Dimens.standard_2,
                          ),
                        ),
                        const SizedBox(height: Dimens.standard_8),

                        // Tagline text
                        Text(
                          AppStrings.appSubtitle,
                          style: AppTextStyles.openSansRegular14.copyWith(
                            color: AppColors.colorWhite.withValues(
                              alpha: Dimens.decimal_8,
                            ),
                            letterSpacing: Dimens.standard_1,
                          ),
                        ),
                        const SizedBox(height: Dimens.standard_60),

                        // Loading spinner to show something is happening
                        CustomLoader(
                          size: Dimens.standard_24,
                          strokeWidth: Dimens.standard_2_5,
                          isCentered: false,
                          color: AppColors.colorWhite.withValues(
                            alpha: Dimens.decimal_8,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/features/instamart/presentation/pages/instamart_home_page.dart';
import 'package:bloc_advanced/features/login/presentation/pages/login.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_advanced/features/splash/presentation/pages/splash_screen.dart';

/// Global navigator key for accessing navigation context outside widgets.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// GoRouter Configuration
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    /// Splash screen
    GoRoute(
      path: RoutesName.defaultPath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    
    /// Login screen
    GoRoute(
      path: RoutesName.loginPath,
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
    ),
    
    /// Instamart Home screen
    GoRoute(
      path: RoutesName.homePage,
      builder: (BuildContext context, GoRouterState state) {
        return const InstamartHomePage();
      },
    ),
  ],
);

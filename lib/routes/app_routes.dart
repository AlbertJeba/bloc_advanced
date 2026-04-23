import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/features/dashboard/presentation/pages/dashboard.dart';
import 'package:bloc_advanced/features/login/presentation/pages/login.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_advanced/features/splash/presentation/pages/splash_screen.dart';

/// Global navigator key for accessing navigation context outside widgets.
/// 
/// Useful for navigation from non-widget code (e.g., interceptors, services).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// GoRouter Configuration
/// 
/// Defines all routes in the application using declarative routing.
/// 
/// Routes:
/// - `/` (defaultPath) → SplashScreen
/// - `/login` → Login
/// - `/home` → Dashboard
/// 
/// Usage in widgets:
/// ```dart
/// context.go(RoutesName.homePage);
/// context.push(RoutesName.loginPath);
/// ```
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    /// Splash screen - initial route
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
    
    /// Dashboard/Home screen
    GoRoute(
      path: RoutesName.homePage,
      builder: (BuildContext context, GoRouterState state) {
        return const Dashboard();
      },
    ),
  ],
);

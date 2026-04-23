/// RoutesName
///
/// This class defines all the screen names (routes) used for navigation.
///
/// Why use constants?
/// - Prevents typos in route names.
/// - Makes it easy to see all available screens in one place.
///
/// Used with GoRouter in `app_routes.dart`.
class RoutesName {
  /// Root path (usually redirects to Splash or Login)
  static const defaultPath = '/';

  /// Onboarding screen (if applicable)
  static const onBoardingPath = '/onBoarding';

  /// Login screen path
  static const loginPath = '/login';

  /// Dashboard / Home screen path
  static const homePage = '/home';

  /// Sign up screen path (currently unused)
  static const signUp = '/sign-up';
}

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

  /// Product detail screen path
  static const productDetail = '/product-detail';

  /// Cart screen path
  static const cart = '/cart';

  /// Checkout screen path
  static const checkout = '/checkout';

  /// Order Success screen path
  static const orderSuccess = '/order-success';

  /// Wishlist screen path
  static const wishlist = '/wishlist';

  /// User Profile screen path
  static const profile = '/profile';

  /// My Orders screen path
  static const orders = '/orders';

  /// Order Detail screen path
  static const orderDetail = '/order-detail';

  /// Sign up screen path
  static const signUp = '/sign-up';
}

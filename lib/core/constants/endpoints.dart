/// ApiEndpoint
///
/// Contains all API endpoint paths for the Grocery Store backend service.
/// Combined with `EnvInfo.baseUrl` (e.g. `http://127.0.0.1:3000/api/v1/`).
class ApiEndpoint {
  /// Auth endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String authMe = 'auth/me';
  static const String refreshToken = 'auth/refresh';
  static const String profile = 'auth/profile';
  static const String logout = 'auth/logout';

  /// Home & Banners
  static const String homeFeed = 'home/feed';
  static const String banners = 'banners';

  /// Catalog endpoints
  static const String categories = 'categories';
  static const String products = 'products';
  static const String productSearch = 'products/search';
  static const String productDeals = 'products/deals';

  /// Cart endpoints
  static const String cart = 'cart';
  static const String cartItems = 'cart/items';

  /// Addresses endpoints
  static const String addresses = 'addresses';
  static const String checkService = 'addresses/check-service';

  /// Orders & Checkout
  static const String checkoutSummary = 'orders/checkout-summary';
  static const String orders = 'orders';

  /// Wishlist endpoints
  static const String wishlist = 'wishlist';
  static const String wishlistToggle = 'wishlist/toggle';

  /// Coupons endpoints
  static const String coupons = 'coupons';
  static const String applyCoupon = 'coupons/apply';
}

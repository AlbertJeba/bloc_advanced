import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/features/cart/presentation/pages/cart_page.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';
import 'package:bloc_advanced/features/checkout/presentation/pages/checkout_page.dart';
import 'package:bloc_advanced/features/checkout/presentation/pages/order_success_page.dart';
import 'package:bloc_advanced/features/grocery/presentation/pages/grocery_home_page.dart';
import 'package:bloc_advanced/features/grocery/presentation/pages/product_detail_page.dart';
import 'package:bloc_advanced/features/login/presentation/pages/login.dart';
import 'package:bloc_advanced/features/login/presentation/pages/sign_up_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_advanced/features/splash/presentation/pages/splash_screen.dart';
import 'package:bloc_advanced/features/wishlist/presentation/pages/wishlist_page.dart';

import 'package:bloc_advanced/features/profile/presentation/pages/profile_page.dart';
import 'package:bloc_advanced/features/orders/presentation/pages/orders_page.dart';
import 'package:bloc_advanced/features/orders/presentation/pages/order_details_page.dart';

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

    /// Sign Up screen
    GoRoute(
      path: RoutesName.signUp,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpPage();
      },
    ),

    /// Home screen
    GoRoute(
      path: RoutesName.homePage,
      builder: (BuildContext context, GoRouterState state) {
        return const GroceryHomePage();
      },
    ),

    /// Product Detail screen
    GoRoute(
      path: RoutesName.productDetail,
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.extra as String? ?? '';
        return ProductDetailPage(productId: productId);
      },
    ),

    /// Cart screen
    GoRoute(
      path: RoutesName.cart,
      builder: (BuildContext context, GoRouterState state) {
        return const CartPage();
      },
    ),

    /// Checkout screen
    GoRoute(
      path: RoutesName.checkout,
      builder: (BuildContext context, GoRouterState state) {
        return const CheckoutPage();
      },
    ),

    /// Order Success screen
    GoRoute(
      path: RoutesName.orderSuccess,
      builder: (BuildContext context, GoRouterState state) {
        final order = state.extra as OrderData?;
        return OrderSuccessPage(order: order);
      },
    ),

    /// Wishlist screen
    GoRoute(
      path: RoutesName.wishlist,
      builder: (BuildContext context, GoRouterState state) {
        return const WishlistPage();
      },
    ),

    /// Profile screen
    GoRoute(
      path: RoutesName.profile,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),

    /// Orders screen
    GoRoute(
      path: RoutesName.orders,
      builder: (BuildContext context, GoRouterState state) {
        return const OrdersPage();
      },
    ),

    /// Order Details screen
    GoRoute(
      path: RoutesName.orderDetail,
      builder: (BuildContext context, GoRouterState state) {
        final orderId = state.extra as String? ?? '';
        return OrderDetailPage(orderId: orderId);
      },
    ),
  ],
);

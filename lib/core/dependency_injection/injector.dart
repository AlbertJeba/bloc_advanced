import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/database/secure_storage_service.dart';
import 'package:bloc_advanced/core/network/connection/network_info.dart';
import 'package:bloc_advanced/core/network/dio_network_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc_advanced/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:bloc_advanced/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:bloc_advanced/features/cart/domain/repositories/cart_repository.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';
import 'package:bloc_advanced/features/grocery/data/data_source/grocery_remote_data_source.dart';
import 'package:bloc_advanced/features/grocery/data/repositories/grocery_repository_impl.dart';
import 'package:bloc_advanced/features/grocery/domain/repositories/grocery_repository.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_grocery_items_use_case.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_product_detail_use_case.dart';
import 'package:bloc_advanced/features/login/data/data_source/login_remote_data_source.dart';
import 'package:bloc_advanced/features/login/data/repositories/login_repository_impl.dart';
import 'package:bloc_advanced/features/login/domain/repositories/login_repository.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_use_case.dart';
import 'package:bloc_advanced/features/checkout/data/data_source/checkout_remote_data_source.dart';
import 'package:bloc_advanced/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:bloc_advanced/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:bloc_advanced/features/checkout/domain/use_case/checkout_use_case.dart';
import 'package:bloc_advanced/features/wishlist/data/data_source/wishlist_remote_data_source.dart';
import 'package:bloc_advanced/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:bloc_advanced/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:bloc_advanced/features/wishlist/domain/use_case/wishlist_use_case.dart';
import 'package:bloc_advanced/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:bloc_advanced/features/orders/data/repositories/order_repository_impl.dart';
import 'package:bloc_advanced/features/orders/domain/repositories/order_repository.dart';
import 'package:bloc_advanced/features/orders/domain/use_case/order_use_case.dart';
import 'package:bloc_advanced/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:bloc_advanced/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bloc_advanced/features/profile/domain/repositories/profile_repository.dart';
import 'package:bloc_advanced/features/profile/domain/use_case/profile_use_case.dart';
import 'package:get_it/get_it.dart';

/// Service Locator Instance
final injector = GetIt.instance;

/// Dependency Injection Setup
///
/// This function initializes all services, data sources, repositories,
/// and use cases for the application. It follows a layered registration
/// approach to ensure dependencies are resolved correctly.
Future<void> init() async {
  /// --- Core Services (Layer 0) ---
  final secureStorage = SecureStorageService();
  injector.registerLazySingleton<SecureStorageService>(() => secureStorage);

  final hiveService = HiveService(secureStorage);
  await hiveService.init();
  injector.registerLazySingleton<HiveService>(() => hiveService);

  injector.registerLazySingleton<NetworkService>(DioNetworkService.new);
  injector.registerLazySingleton<Connectivity>(Connectivity.new);
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(injector()),
  );

  /// --- DataSources (Layer 1) ---
  injector
    // Login Data Source
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(injector()),
    )
    // Grocery Data Source
    ..registerLazySingleton<GroceryRemoteDataSource>(
      () => GroceryRemoteDataSourceImpl(injector()),
    )
    // Cart Data Source
    ..registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(injector()),
    )
    // Checkout Data Source
    ..registerLazySingleton<CheckoutRemoteDataSource>(
      () => CheckoutRemoteDataSourceImpl(injector()),
    )
    // Wishlist Data Source
    ..registerLazySingleton<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImpl(injector()),
    )
    // Order Data Source
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(injector()),
    )
    // Profile Data Source
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(injector()),
    )
    /// --- Repositories (Layer 2) ---
    // Login Repo
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injector()),
    )
    // Grocery Repo
    ..registerLazySingleton<GroceryRepository>(
      () => GroceryRepositoryImpl(injector()),
    )
    // Cart Repo
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(injector()),
    )
    // Checkout Repo
    ..registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(injector()),
    )
    // Wishlist Repo
    ..registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(injector()),
    )
    // Order Repo
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(injector()),
    )
    // Profile Repo
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(injector()),
    )
    /// --- UseCases (Layer 3) ---
    // Login Logic
    ..registerLazySingleton<LoginUseCases>(() => LoginUseCases(injector()))
    // Grocery Logic
    ..registerLazySingleton<GetGroceryItemsUseCase>(
      () => GetGroceryItemsUseCase(injector()),
    )
    ..registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(injector()),
    )
    // Cart Logic
    ..registerLazySingleton<CartUseCase>(() => CartUseCase(injector()))
    // Checkout Logic
    ..registerLazySingleton<CheckoutUseCase>(() => CheckoutUseCase(injector()))
    // Wishlist Logic
    ..registerLazySingleton<WishlistUseCase>(() => WishlistUseCase(injector()))
    // Order Logic
    ..registerLazySingleton<OrderUseCase>(() => OrderUseCase(injector()))
    // Profile Logic
    ..registerLazySingleton<ProfileUseCase>(() => ProfileUseCase(injector()));
}

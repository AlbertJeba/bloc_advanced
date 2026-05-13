import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/database/secure_storage_service.dart';
import 'package:bloc_advanced/core/network/dio_network_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/features/instamart/data/datasource/instamart_remote_data_source.dart';
import 'package:bloc_advanced/features/instamart/data/repositories/instamart_repository_impl.dart';
import 'package:bloc_advanced/features/instamart/domain/repositories/instamart_repository.dart';
import 'package:bloc_advanced/features/instamart/domain/use_case/get_instamart_items_usecase.dart';
import 'package:bloc_advanced/features/login/data/datasource/login_remote_data_source.dart';
import 'package:bloc_advanced/features/login/data/repositories/login_repository_impl.dart';
import 'package:bloc_advanced/features/login/domain/repositories/login_repository.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_usecase.dart';
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

  /// --- DataSources (Layer 1) ---
  injector
    // Login Data Source
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(injector()),
    )
    // Instamart Data Source
    ..registerLazySingleton<InstamartRemoteDataSource>(
      () => InstamartRemoteDataSourceImpl(injector()),
    )

    /// --- Repositories (Layer 2) ---
    // Login Repo
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injector()),
    )
    // Instamart Repo
    ..registerLazySingleton<InstamartRepository>(
      () => InstamartRepositoryImpl(injector()),
    )

    /// --- UseCases (Layer 3) ---
    // Login Logic
    ..registerLazySingleton<LoginUseCases>(() => LoginUseCases(injector()))
    // Instamart Logic
    ..registerLazySingleton<GetInstamartItemsUseCase>(
      () => GetInstamartItemsUseCase(injector()),
    );
}

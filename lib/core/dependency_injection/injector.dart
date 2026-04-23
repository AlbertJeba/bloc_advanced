import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/database/secure_storage_service.dart';
import 'package:bloc_advanced/core/network/dio_network_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:bloc_advanced/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bloc_advanced/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bloc_advanced/features/dashboard/domain/use_case/get_products_usecase.dart';
import 'package:bloc_advanced/features/login/data/datasource/login_remote_data_source.dart';
import 'package:bloc_advanced/features/login/data/repositories/login_repository_impl.dart';
import 'package:bloc_advanced/features/login/domain/repositories/login_repository.dart';
import 'package:bloc_advanced/features/login/domain/use_case/login_usecase.dart';
import 'package:get_it/get_it.dart';

/// Dependency Injection (DI) Setup
/// 
/// We use the `get_it` package to manage dependencies.
/// 
/// What is DI?
/// Instead of creating new objects everywhere (e.g. `Repository repo = Repository()`),
/// we create them ONCE here and reuse them. 
/// 
/// Why?
/// - Easier testing (we can swap real DB with fake DB).
/// - Saves memory (Singletons).
/// - Cleaner code (no massive constructor chains).
final injector = GetIt.instance;

/// Call this function in `main.dart` to set up everything.
Future<void> init() async {
  injector
    /// --- Core Services ---
    // Network Service (handles API calls)
    ..registerLazySingleton<NetworkService>(DioNetworkService.new)
    // Secure Storage (handles encryption keys)
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    // Hive Service (handles Local DB)
    ..registerLazySingleton<HiveService>(() => HiveService(injector()))

    /// --- DataSources (Layer 1) ---
    // Login Data Source
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(injector()),
    )
    // Dashboard Data Source
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(injector()),
    )

    /// --- Repositories (Layer 2) ---
    // Login Repo
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injector()),
    )
    // Dashboard Repo
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(injector()),
    )

    /// --- UseCases (Layer 3) ---
    // Login Logic
    ..registerLazySingleton<LoginUseCases>(() => LoginUseCases(injector()))
    // Dashboard Logic
    ..registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(injector()),
    );
}

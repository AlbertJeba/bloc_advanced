import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/routes/app_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// LogoutService
///
/// A single Singleton class to handle the entire logout process.
/// This ensures logout logic is consistent properly everywhere.
class LogoutService {
  // Private constructor
  LogoutService._internal({
    required this.hiveService,
    required this.networkService,
    required this.userPreferences,
  });

  // The single instance of this class
  static final LogoutService _instance = LogoutService._internal(
    hiveService: GetIt.instance<HiveService>(),
    networkService: GetIt.instance<NetworkService>(),
    userPreferences: UserPreferences.instance,
  );

  // Access point for the instance
  static LogoutService get instance => _instance;

  final HiveService hiveService;
  final NetworkService? networkService;
  final UserPreferences userPreferences;

  /// Performs full logout and redirects to Login screen
  Future<void> logoutAndNavigate() async {
    await clearData();
  }

  /// Clears all user data
  /// 1. Clears local database (Hive)
  /// 2. Clears in-memory user preferences
  /// 3. Removes Auth Token from API headers
  /// 4. Navigates to Login Screen
  Future<void> clearData() async {
    final hive = hiveService;
    await hive.clear();
    userPreferences.clearPreferences();
    networkService?.updateHeader({'Authorization': ''});
    navigatorKey.currentContext?.go(RoutesName.loginPath);
  }
}

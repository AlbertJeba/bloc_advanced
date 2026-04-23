import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/constants/app_language.dart';
import 'core/database/hive_storage_service.dart';
import 'core/dependency_injection/injector.dart';
import 'main/app.dart';
import 'main/app_env.dart';

/// Production entry point.
/// 
/// This is the default entry point when running `flutter run` without
/// specifying a target file. It initializes the app in Production mode.
void main() => mainCommon(AppEnvironment.prod);

/// Common initialization function shared across all environments.
/// 
/// This function:
/// 1. Ensures Flutter bindings are initialized
/// 2. Locks the app to portrait orientation
/// 3. Initializes the environment configuration
/// 4. Loads translation files for localization
/// 5. Sets up dependency injection
/// 6. Initializes local storage (Hive)
/// 7. Runs the app
/// 
/// [environment] - The target environment (dev, stage, prod)
Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize environment-specific configuration
  EnvInfo.initialize(environment);
  
  // Load translations for the app
  Map<String, Map<String, String>> translations = await loadTranslations();
  
  // Initialize dependency injection
  await init();
  
  // Initialize local database
  await injector<HiveService>().init();
  
  // Run the app
  runApp(MyApp(languageConfig: translations));
}

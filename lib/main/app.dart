import 'package:bloc_advanced/core/constants/app_language.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:bloc_advanced/routes/app_routes.dart';
import 'package:bloc_advanced/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

/// MyApp - Root Widget of the Application
/// 
/// This is the top-level widget that configures the app with:
/// - Theme configuration (light theme)
/// - Localization/translations
/// - Routing setup using GoRouter
/// - Debug banner visibility
/// 
/// Uses [GetMaterialApp.router] to combine GetX utilities with GoRouter navigation.
class MyApp extends StatelessWidget {
  /// Creates the root app widget.
  /// 
  /// [languageConfig] - Map of translations loaded from assets/language/
  const MyApp({super.key, required this.languageConfig});

  /// Language configuration map for translations.
  /// 
  /// Structure: {'en': {'key': 'value'}, 'es': {'key': 'valor'}}
  final Map<String, Map<String, String>> languageConfig;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: EnvInfo.appName, // Dynamic title based on environment
      theme: AppTheme.lightTheme,
      translations: AppTranslations(languageConfig),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}

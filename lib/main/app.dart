import 'package:bloc_advanced/core/constants/app_language.dart';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:bloc_advanced/routes/app_routes.dart';
import 'package:bloc_advanced/shared/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

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
  const MyApp({
    super.key,
    required this.languageConfig,
    this.initialLocale = const Locale('en'),
  });

  /// Language configuration map for translations.
  final Map<String, Map<String, String>> languageConfig;
  final Locale initialLocale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: EnvInfo.appName,
      // Dynamic title based on environment
      theme: AppTheme.lightTheme,
      translations: AppTranslations(languageConfig),
      locale: initialLocale,
      fallbackLocale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ta'), Locale('hi')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final currentLang =
            Get.locale?.languageCode ?? HiveStorageService().getLanguage();
        final isTamil = currentLang == 'ta';
        final tamilScale = defaultTargetPlatform == TargetPlatform.iOS
            ? 0.80
            : 0.70;

        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(isTamil ? tamilScale : 1.0)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}

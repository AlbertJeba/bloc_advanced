import 'dart:convert';
import 'package:bloc_advanced/core/database/hive_storage_service.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constant.dart';

/// Supported language model
class LanguageOption {
  final String code;
  final String name;
  final String nativeName;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

/// Helper class for managing and switching application languages
class AppLanguage {
  static const String english = 'en';
  static const String tamil = 'ta';
  static const String hindi = 'hi';

  static const List<LanguageOption> supportedLanguages = [
    LanguageOption(code: english, name: 'English', nativeName: 'English'),
    LanguageOption(code: tamil, name: 'Tamil', nativeName: 'தமிழ்'),
    LanguageOption(code: hindi, name: 'Hindi', nativeName: 'हिन्दी'),
  ];

  /// Switches language globally and stores preference in Hive
  static Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    await Get.updateLocale(locale);
    try {
      final hive = injector<HiveService>();
      await hive.set(languageDbKey, languageCode);
    } catch (_) {}
  }

  /// Retrieves previously saved locale from Hive, defaulting to English
  static Future<Locale> getInitialLocale() async {
    try {
      final hive = injector<HiveService>();
      final savedCode = await hive.get(languageDbKey);
      if (savedCode != null &&
          (savedCode == 'en' || savedCode == 'ta' || savedCode == 'hi')) {
        return Locale(savedCode.toString());
      }
    } catch (_) {}
    return const Locale('en');
  }
}

/// AppTranslations
///
/// This class manages the app's language translations using the GetX package.
class AppTranslations extends Translations {
  final Map<String, Map<String, String>> translations;

  AppTranslations(this.translations);

  @override
  Map<String, Map<String, String>> get keys => translations;
}

/// Helper function to load translations from the JSON files.
///
/// This is called in `main.dart` before the app starts.
Future<Map<String, Map<String, String>>> loadTranslations() async {
  // Read translation files from assets
  final enJson = await rootBundle.loadString(englishLanguage);
  final taJson = await rootBundle.loadString(tamilLanguage);
  final hiJson = await rootBundle.loadString(hindiLanguage);

  // Convert strings to JSON maps
  final Map<String, dynamic> enMap = json.decode(enJson);
  final Map<String, dynamic> taMap = json.decode(taJson);
  final Map<String, dynamic> hiMap = json.decode(hiJson);

  // Return formatted for GetX
  return {
    'en': Map<String, String>.from(enMap),
    'ta': Map<String, String>.from(taMap),
    'hi': Map<String, String>.from(hiMap),
  };
}

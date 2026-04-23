import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'constant.dart';

/// AppTranslations
///
/// This class manages the app's language translations using the GetX package.
///
/// How it works:
/// 1. We load the JSON file (`assets/language/en.json`).
/// 2. We convert it into a Map.
/// 3. The app uses keys (like "LOGIN") to look up the correct text.
class AppTranslations extends Translations {
  final Map<String, Map<String, String>> translations;

  AppTranslations(this.translations);

  @override
  Map<String, Map<String, String>> get keys => translations;
}

/// Helper function to load translations from the JSON file.
///
/// This is called in `main.dart` before the app starts.
Future<Map<String, Map<String, String>>> loadTranslations() async {
  // Read the file as a string
  String enJson = await rootBundle.loadString(englishLanguage);

  // Convert string to JSON object (Map)
  Map<String, dynamic> enMap = json.decode(enJson);

  // Return formatted for GetX
  return {
    'en': Map<String, String>.from(enMap),
  };
}

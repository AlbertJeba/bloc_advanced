import 'package:get/get_utils/get_utils.dart';

/// AppStrings - Centralized String Registry
/// 
/// This class provides type-safe access to localized strings defined in en.json.
/// It uses the GetX `.tr` extension to handle translations.
/// 
/// Usage:
/// ```dart
/// Text(AppStrings.welcomeBack)
/// ```
class AppStrings {
  // General
  static String get appName => "APP_NAME".tr;
  static String get appSubtitle => "APP_SUBTITLE".tr;
  static String get loading => "LOADING".tr;
  static String get error => "ERROR".tr;
  static String get retry => "RETRY".tr;
  static String get cancel => "CANCEL".tr;
  static String get errorSomethingWrong => "ERROR_SOMETHING_WRONG".tr;
  static String get success => "SUCCESS".tr;
  static String get info => "INFO".tr;
  static String get warning => "WARNING".tr;

  // Network & Errors
  static String get sessionExpiryMsg => "SESSION_EXPIRY_MSG".tr;
  static String get noInternetMsg => "NO_INTERNET_MSG".tr;
  static String get errorOccurred => "ERROR_OCCURRED".tr;
  static String get unableToConnect => "UNABLE_TO_CONNECT".tr;
  static String get unknownError => "UNKNOWN_ERROR".tr;

  // Login
  static String get login => "LOGIN".tr;
  static String get welcomeBack => "WELCOME_BACK".tr;
  static String get signInContinue => "SIGN_IN_CONTINUE".tr;
  static String get username => "USERNAME".tr;
  static String get password => "PASSWORD".tr;
  static String get usernameValidation => "USERNAME_VALIDATION_TEXT".tr;
  static String get passwordValidation => "PASSWORD_VALIDATION_TEXT".tr;
  static String get enterUsername => "ENTER_USERNAME".tr;
  static String get enterPassword => "ENTER_PASSWORD".tr;
  static String get testCredentials => "TEST_CREDENTIALS".tr;
  static String get testUserCredentials => "TEST_USER_CREDENTIALS".tr;

  // Dashboard
  static String get dashboard => "DASHBOARD".tr;
  static String get products => "PRODUCTS".tr;
  static String get welcome => "WELCOME".tr;
  static String get logout => "LOGOUT".tr;
  static String get logoutConfirm => "LOGOUT_CONFIRM".tr;
  static String get noProducts => "NO_PRODUCTS".tr;
  static String get user => "USER".tr;
  static String get userInitial => "USER_INITIAL".tr;
}

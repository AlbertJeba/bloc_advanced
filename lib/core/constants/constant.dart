import 'package:bloc_advanced/main/app_env.dart';

/// App Constants
///
/// This file contains global constant values used throughout the application.
/// Keeping them here makes them easy to find and change.

const file = 'file';

/// Path to the English translation file
const englishLanguage = 'assets/language/en.json';

/// Database Keys (used for Hive storage)
const userDbKey = 'userDbKey'; // Key to store user object
const userToken = 'token';     // Key to store auth token
const refreshToken = 'refreshToken'; // Key to store refresh token
const sendOtpFlag = 'send';
const verifyOtpFlag = 'verify';
const seenOnboarding = 'seenOnboarding';

/// Pagination limit (how many items to load per page)
const pageLimit = 20;

/// Token expiry time in minutes (specifically for DummyJSON API simulation)
const tokenExpiryMins = 10;

/// Web URLs
/// These use EnvInfo to get the correct URL based on the environment (Dev/Prod).
String termsAndConditionsURL = '${EnvInfo.webPageUrl}/terms-of-use';
String privacyPolicyURL = '${EnvInfo.webPageUrl}/privacy-policy';
String aboutUsURL = '${EnvInfo.webPageUrl}/about-us';
String accountDeletion = '${EnvInfo.webPageUrl}/delete-account';

/// Store URLs (for linking to App Store / Play Store)
const androidStore = '';
const iosStore = '';

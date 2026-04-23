import 'package:bloc_advanced/core/extension/roles.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';

/// UserPreferences
///
/// This class holds "In-Memory" user data using the Singleton pattern.
///
/// What does that mean?
/// - "Singleton": There is only ONE copy of this class in the entire app.
/// - "In-Memory": If you close the app completely, this data is lost (unless we save it to Hive).
///
/// We use this to quickly access user info (like Name, Role, Token) anywhere in the app
/// without reading from the database every single time.
class UserPreferences {
  // Private constructor (prevents creating new instances)
  UserPreferences._();

  // The single instance
  static final UserPreferences _instance = UserPreferences._();

  // Access the instance
  static UserPreferences get instance => _instance;

  // --- Stored Data ---
  UserData? _user;
  UserRole? _userRole;
  String? _fcmToken;
  bool notificationReadIcon = false;

  /// Setup user after login
  void setUser(UserData user) {
    _user = user;
  }

  UserData? getUser() {
    return _user;
  }

  /// Store user role (Admin vs Customer)
  void setUserRole(UserRole role) {
    _userRole = role;
  }

  UserRole? getUserRole() {
    return _userRole;
  }

  /// Store Push Notification Token (Firebase)
  String? getFCMToken() {
    return _fcmToken;
  }

  void setFCMToken(String token) {
    _fcmToken = token;
  }

  /// Manage notification badge
  void setNotificationReadIcon(bool value) {
    notificationReadIcon = value;
  }

  bool getNotificationReadIcon() {
    return notificationReadIcon;
  }

  /// Clear everything (Logout)
  void clearPreferences() {
    _user = null;
    _userRole = null;
    _fcmToken = null;
  }
}

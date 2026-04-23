/// AssetPath
///
/// This class holds the paths to all static assets in the app (like images and icons).
///
/// Why do we do this?
/// - To avoid typos when typing paths manually.
/// - If we move an image, we only change the path in one place.
///
/// Example:
/// Instead of writing "assets/icons/email.svg" everywhere,
/// we use `AssetPath.emailIcon`.
class AssetPath {
  /// Path to the app logo shown on Splash Screen
  static String splashIcon = "assets/icons/flutter_logo.svg";

  /// Email icon used in input fields
  static String emailIcon = "assets/icons/email.svg";

  /// Eye icon to show password
  static String eyeOpenIcon = "assets/icons/eye_open.svg";

  /// Eye icon to hide password
  static String eyeClosedIcon = "assets/icons/eye_closed.svg";
}

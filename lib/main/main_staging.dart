import 'package:bloc_advanced/main.dart';
import 'package:bloc_advanced/main/app_env.dart';

/// Staging/UAT environment entry point.
/// 
/// Run this with: `flutter run -t lib/main/main_staging.dart`
/// 
/// This entry point:
/// - Uses staging API endpoints (mirror of production)
/// - Used for final testing before production release
/// - QA team testing environment
Future<void> main() async => mainCommon(AppEnvironment.stage);

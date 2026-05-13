import 'package:permission_handler/permission_handler.dart';

/// PermissionService
/// 
/// Manages system permissions (Camera, Photos, etc.)
class PermissionService {
  /// Checks and requests Photo/Gallery permission
  static Future<bool> requestPhotoPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Checks and requests Camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Opens App Settings if permission is permanently denied
  static Future<void> openSettings() async {
    await openAppSettings();
  }
}

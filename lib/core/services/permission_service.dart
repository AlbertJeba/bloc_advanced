import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:permission_handler/permission_handler.dart';

/// PermissionService
///
/// Manages system permissions (Camera, Photos, etc.)
class PermissionService {
  static bool _isRequesting = false;

  /// Checks and requests Photo/Gallery permission
  static Future<bool> requestPhotoPermission() async {
    if (_isRequesting) return false;
    _isRequesting = true;
    try {
      final status = await Permission.photos.request();
      return status.isGranted;
    } catch (e) {
      ErrorLogger.log('PermissionService.requestPhotoPermission', e);
      return false;
    } finally {
      _isRequesting = false;
    }
  }

  /// Checks and requests Camera permission
  static Future<bool> requestCameraPermission() async {
    if (_isRequesting) return false;
    _isRequesting = true;
    try {
      final status = await Permission.camera.request();
      return status.isGranted;
    } catch (e) {
      ErrorLogger.log('PermissionService.requestCameraPermission', e);
      return false;
    } finally {
      _isRequesting = false;
    }
  }

  /// Opens App Settings if permission is permanently denied
  static Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      ErrorLogger.log('PermissionService.openSettings', e);
    }
  }
}

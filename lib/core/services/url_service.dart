import 'package:url_launcher/url_launcher.dart';

/// UrlService
/// 
/// A service to launch external URLs, phone calls, and emails.
class UrlService {
  /// Launches a web URL in the system browser
  static Future<void> launchWebUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  /// Initiates a phone call
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw 'Could not call $phoneNumber';
    }
  }

  /// Opens the email app
  static Future<void> sendEmail(String email, {String? subject}) async {
    final Uri uri = Uri.parse('mailto:$email?subject=${subject ?? ''}');
    if (!await launchUrl(uri)) {
      throw 'Could not email $email';
    }
  }
}

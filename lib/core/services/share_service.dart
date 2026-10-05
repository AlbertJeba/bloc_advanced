import 'package:share_plus/share_plus.dart';

/// ShareService
///
/// A central service to handle sharing content to other platforms.
class ShareService {
  /// Shares plain text to any platform (WhatsApp, Email, etc.)
  static Future<void> shareText(String text, {String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  /// Shares a URL/Link
  static Future<void> shareLink(String url, {String? text}) async {
    await SharePlus.instance.share(ShareParams(text: url, subject: text));
  }
}

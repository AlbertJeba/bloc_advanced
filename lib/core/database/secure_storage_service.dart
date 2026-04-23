import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// SecureStorageService
/// 
/// Handles secure storage operations using flutter_secure_storage.
/// Primarily used to store the encryption key for Hive.
class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _encryptionKeyName = 'hive_encryption_key';

  /// Generates or retrieves a 256-bit encryption key for Hive.
  Future<List<int>> getEncryptionKey() async {
    final containsEncryptionKey = await _secureStorage.containsKey(key: _encryptionKeyName);
    
    if (!containsEncryptionKey) {
      // Generate a new 256-bit key
      final key = Hive.generateSecureKey();
      // Store it as a base64 string
      await _secureStorage.write(
        key: _encryptionKeyName,
        value: base64UrlEncode(key),
      );
    }

    // Retrieve and decode the key
    final base64Key = await _secureStorage.read(key: _encryptionKeyName);
    return base64Url.decode(base64Key!);
  }

  /// Deletes the encryption key (use with caution!)
  Future<void> deleteEncryptionKey() async {
    await _secureStorage.delete(key: _encryptionKeyName);
  }
}

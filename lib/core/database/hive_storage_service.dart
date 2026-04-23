import 'dart:async';
import 'dart:convert';
import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/core/database/storage_service.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// HiveService
///
/// Implementation of StorageService using Hive NoSQL database.
///
/// What is Hive?
/// - A super fast, lightweight key-value database for Flutter.
/// - We use it to save things like the User's Login Token so they stay logged in.
class HiveService implements StorageService {
  Box? box;

  // Completer is used to wait for the box to open if it hasn't yet
  final Completer<Box> initCompleter = Completer<Box>();

  /// Initialize the database
  @override
  Future<void> init() async {
    await Hive.initFlutter();
    // Open a box named 'bloc2025HiveService'
    initCompleter.complete(Hive.openBox('bloc2025HiveService'));
  }

  /// Check if database is ready
  @override
  bool get hasInitialized => initCompleter.isCompleted;

  /// Get a value by its key
  @override
  Future<Object?> get(String key) async {
    box = await initCompleter.future;
    return box?.get(key);
  }

  /// Clear all data (used during logout)
  @override
  Future<void> clear() async {
    box = await initCompleter.future;
    // Clearing specific fields or the whole box
    await box?.put('user', {}.toString());
    await box?.clear();
  }

  /// Check if a key exists
  @override
  Future<bool> has(String key) async {
    box = await initCompleter.future;
    return box?.containsKey(key) ?? false;
  }

  /// Remove a specific item
  @override
  Future<bool> remove(String key) async {
    box = await initCompleter.future;
    await box?.delete(key);
    return true;
  }

  /// Save a value
  @override
  Future<bool> set(String key, data) async {
    box = await initCompleter.future;
    await box?.put(key, data.toString());
    return true;
  }

  /// Helper to save the UserData object
  /// We convert the object to JSON string because Hive stores simple types best.
  @override
  Future<bool> setUser(UserData data) async {
    box = await initCompleter.future;
    await box?.put(userDbKey, jsonEncode(data.toJson()));
    return true;
  }

  /// Helper to get the UserData object
  @override
  Future<UserData> getUser() async {
    Object? data = await box?.get(userDbKey);
    dynamic userJson = jsonDecode(data.toString());
    return UserData.fromJson(userJson);
  }
}

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// ConnectionStatusListener
///
/// Listens for internet connection changes (Online / Offline).
///
/// How it works:
/// 1. Uses `connectivity_plus` to detect network changes (WiFi/Mobile).
/// 2. Pings a reliable server (google.com) to verify actual internet access.
/// 3. Broadcasts the status to the rest of the app via a Stream.
class ConnectionStatusListener {
  // Singleton instance
  static final _singleton = ConnectionStatusListener._internal();

  ConnectionStatusListener._internal();

  bool hasShownNoInternet = false;

  // Tools
  final Connectivity _connectivity = Connectivity();

  // Public access
  static ConnectionStatusListener getInstance() => _singleton;

  // Tracker
  bool hasConnection = false;

  // Controller to send updates to listeners
  StreamController connectionChangeController = StreamController.broadcast();

  // Stream that UI can listen to
  Stream get connectionChange => connectionChangeController.stream;

  /// Internal listener for connectivity_plus
  void _connectionChange(List<ConnectivityResult> results) {
    if (results.isNotEmpty) {
      checkConnection();
    }
  }

  /// Real test: tries to lookup google.com to verify internet
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    // If status changed, notify listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  /// Initialize listener (call this at app start)
  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  /// Cleanup
  void dispose() {
    connectionChangeController.close();
  }
}

/// Helper to handle UI updates when connection changes
void updateConnectivity(
  dynamic hasConnection,
  ConnectionStatusListener connectionStatus,
) {
  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    // Here we can show a "No Internet" popup or banner
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
    }
  }
}

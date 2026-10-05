import 'package:connectivity_plus/connectivity_plus.dart';

/// NetworkInfo
///
/// Abstract contract for checking network connection.
/// Mockable and injectable for Clean Architecture testing.
abstract class NetworkInfo {
  Future<bool> get isConnected;

  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

/// NetworkInfoImpl
///
/// Production implementation of [NetworkInfo] using [Connectivity].
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}

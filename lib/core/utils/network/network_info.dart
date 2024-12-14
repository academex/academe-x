import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get onConnectivityChanged;
  Future<bool> get hasInternetAccess;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl({
    required Connectivity connectivity,
    required InternetConnectionChecker internetConnectionChecker,
  })  : _connectivity = connectivity,
        _internetConnectionChecker = internetConnectionChecker;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  @override
  Future<bool> get hasInternetAccess => _internetConnectionChecker.hasConnection;
}
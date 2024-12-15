import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityCubit() : super(ConnectivityStatus.connected) {
    _initializeConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initializeConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      emit(ConnectivityStatus.disconnected);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
        emit(ConnectivityStatus.connected);
        break;
      default:
        emit(ConnectivityStatus.disconnected);
    }
  }

  bool get isConnected => state == ConnectivityStatus.connected;

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
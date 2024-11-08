import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/connectivity_cubit.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  final Widget? onDisconnected;

  const NetworkAwareWidget({
    required this.child,
    this.onDisconnected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      builder: (context, state) {
        if (state == ConnectivityStatus.disconnected) {
          return onDisconnected ?? _buildDefaultDisconnectedWidget();
        }
        return child;
      },
    );
  }

  Widget _buildDefaultDisconnectedWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'لا يوجد اتصال بالإنترنت',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'يرجى التحقق من اتصالك بالإنترنت',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
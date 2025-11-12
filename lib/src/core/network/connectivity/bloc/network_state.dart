import 'package:equatable/equatable.dart';

abstract class NetworkState extends Equatable {
  final bool isConnected;
  final String networkType;

  const NetworkState({this.isConnected = false, required this.networkType});

  @override
  List<Object?> get props => [isConnected];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial() : super(networkType: 'initial');
}

class NetworkOffline extends NetworkState {
  const NetworkOffline() : super(isConnected: false, networkType: 'offline');
}

class NetworkOnline extends NetworkState {
  const NetworkOnline() : super(isConnected: true, networkType: 'online');
}

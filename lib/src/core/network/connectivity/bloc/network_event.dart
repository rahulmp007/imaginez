import 'package:equatable/equatable.dart';

abstract class NetworkEvent extends Equatable {}

class NetworkStatusChanged extends NetworkEvent {
  final bool isConnected;
  NetworkStatusChanged({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}

class NetwrokRefreshRequested extends NetworkEvent {
  @override
  List<Object?> get props => [];
}

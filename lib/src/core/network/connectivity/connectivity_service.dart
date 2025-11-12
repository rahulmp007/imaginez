

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityService {
  Future<bool> get isNetworkConnected;
  Stream<bool> get getConnectionChanged;
}

class ConnectivityServiceImpl extends ConnectivityService {
  final Connectivity _connectivity;
  final InternetConnectionChecker _connectionChecker;
  ConnectivityServiceImpl({
    Connectivity? connectivity,
    InternetConnectionChecker? checker,
  }) : _connectivity = connectivity ?? Connectivity(),
       _connectionChecker =
           checker ?? InternetConnectionChecker.createInstance();

  @override
  Stream<bool> get getConnectionChanged => _connectivity.onConnectivityChanged.asyncMap((results) {
      final hasNetwork = results.any((r) => r != ConnectivityResult.none);

      return hasNetwork
          ? _connectionChecker.hasConnection
          : Future.value(false);
    });

  @override
  Future<bool> get isNetworkConnected async {
    final results = await _connectivity.checkConnectivity();
    final hasNetwork = results.any(
      (result) => result != ConnectivityResult.none,
    );
    if (!hasNetwork) return false;
    return await _connectionChecker.hasConnection;
  }
}

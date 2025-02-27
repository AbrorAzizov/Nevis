import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  void dispose() {
    _subscription.cancel();
  }

  Stream<bool> get connectivityStream =>
      _connectivity.onConnectivityChanged.map((result) {
        return result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile);
      });

  Future<bool> hasInternetConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile);
  }
}

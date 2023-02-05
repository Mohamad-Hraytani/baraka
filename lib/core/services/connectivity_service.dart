import 'dart:async';

import '../../app/locator.dart';
import 'package:connectivity/connectivity.dart';

enum ConnectivityStatus { Online, Offline }

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    locator<Connectivity>().onConnectivityChanged.listen((status) {
      connectionStatusController.add(_getStatusFromResult(status));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Online;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Online;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Online;
    }
  }
}

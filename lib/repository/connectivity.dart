import 'package:connectivity_plus/connectivity_plus.dart';

class Checkconnectivity {
  Future<bool> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool result = true;
    for (var i in connectivityResult) {
      if (i.name == "none") {
        result = false;
        break;
      }
    }
    return result;
  }

  get connectionStatus async => await checkConnectivity();
}

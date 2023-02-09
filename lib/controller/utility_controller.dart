import 'dart:io';

class UtilityController {
  static final UtilityController _singleton = UtilityController._internal();
  static UtilityController get instance => _singleton;
  factory UtilityController() {
    return _singleton;
  }
  UtilityController._internal();

  bool haveConnect = true;

  Future checkConnect() async {
    try {
      haveConnect = false;
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        haveConnect = true;
      }
    } on SocketException catch (_) {}
  }
}

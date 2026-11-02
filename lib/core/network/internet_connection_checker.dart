import 'dart:io';

abstract final class InternetConnectionChecker {
  static Future<bool> isOnline() async {
    try {
      final addresses = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 3));
      return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
    } on Object {
      return false;
    }
  }
}

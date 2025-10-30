import 'dart:io';
import 'dart:async';
//!                                                     التاكد من انه في نت ولا لا

class InternetCheck {
  /// ✅ ترجع true لو النت موجود، false لو مفيش
  static Future<bool> hasConnection({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(timeout);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}

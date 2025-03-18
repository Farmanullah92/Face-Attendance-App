import 'package:flutter/foundation.dart';

class CommonUtils {
  static void debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

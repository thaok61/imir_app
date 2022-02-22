import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:imir_app/network/music.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;

  bool get isInitialized => _initialized;



  void initializeApp() {
    Timer(const Duration(milliseconds: 5000), () {
      _initialized = true;
      notifyListeners();
    });
  }


}

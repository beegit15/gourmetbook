import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gourmetbook/routes/goRouter.dart';

class Auth with ChangeNotifier {
  bool _showPassworld = false;
  bool get showPassworld => _showPassworld;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool _loading = false;
  bool get loiding => _loading;

  toggleShowPassworld() {
    _showPassworld = !_showPassworld;
    print("hello");
    notifyListeners();
  }

  init() {
    _loading = true;
    Timer(Duration(seconds: 10), () {
      _loading = false;
      _isLoggedIn = false;

      notifyListeners();
      goRouter.go("/login");
    });
  }
}

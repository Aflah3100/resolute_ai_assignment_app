import 'package:flutter/material.dart';

class AuthScrenProvider with ChangeNotifier {
  bool _isLoginValue = true;
  bool _isPasswordVisible = false;

  bool isLoginMode() => _isLoginValue;

  void setLogin(bool value) {
    _isLoginValue = value;
    notifyListeners();
  }

  bool isPasswordVisible() => _isPasswordVisible;

  void setIsPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }
}

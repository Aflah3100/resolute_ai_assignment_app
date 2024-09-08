import 'package:flutter/material.dart';

class AuthScrenProvider with ChangeNotifier {
  bool _isLoginValue = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

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

  bool isLoading() => _isLoading;

  void setLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

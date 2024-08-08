import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String token = "";

  bool get isAuthenticated => _isAuthenticated;
  String get getToken => token;

  Future<void> login(String username, String password) async {
    try {
      final authService = AuthService();
      token = await authService.login(username, password);
      _isAuthenticated = true;
    } catch (e) {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
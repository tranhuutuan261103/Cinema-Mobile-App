import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String token = "";

  bool get isAuthenticated => _isAuthenticated;
  String get getToken => token;

  AuthProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    if (token.isNotEmpty) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      final authService = AuthService();
      token = await authService.login(username, password);
      _isAuthenticated = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<void> register(
    String firstName,
    String lastName,
    String username,
    String phone,
    String email,
    String password,
  ) async {
    try {
      final authService = AuthService();
      token = await authService.register(
        firstName,
        lastName,
        username,
        phone,
        email,
        password,
      );
      _isAuthenticated = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  void logout() async {
    _isAuthenticated = false;
    token = "";
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}

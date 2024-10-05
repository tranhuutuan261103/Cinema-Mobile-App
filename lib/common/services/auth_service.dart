// auth_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/unsafe_http_helper.dart'; // Update with the correct path

class AuthService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/account";

  Future<String> login(String username, String password) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.post(
        Uri.parse("$_baseUrl/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "password": password,
          "rememberMe": true,
          "roleRequest": "Customer",
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["token"];
      } else {
        throw Exception("Failed to login: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to login: $e");
    }
  }

  Future<String> register(String firstName, String lastName, String username,
      String phone, String email, String password) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.post(
        Uri.parse("$_baseUrl/register"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": password,
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": phone,
          "isAcceptRule": true,
          "roleRequest": "Customer",
          "address": null,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["token"];
      } else {
        throw Exception("Failed to login: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to login: $e");
    }
  }
}

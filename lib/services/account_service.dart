// account_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/account.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class AccountService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/account";

  Future<Account> getProfile(String token) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse("$_baseUrl/profile"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Account.fromJson(data);
      } else {
        throw Exception("Failed to get profile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to get profile: $e");
    }
  }
}
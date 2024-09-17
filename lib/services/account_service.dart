// account_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
      return Account.empty();
    }
  }

  Future<Account> updateAvatar(String token, File fileData) async {
    try {
      final ioClient = getUnsafeIOClient();

      // Create a multipart request
      final request = http.MultipartRequest('PUT', Uri.parse("$_baseUrl/avatar"))
        ..headers.addAll({
          "Authorization": "Bearer $token",
        });

      // Attach the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'avatar', // The field name in the form
        fileData.path,
      ));

      // Send the request and get the response
      final response = await ioClient.send(request);

      if (response.statusCode == 200) {
        // Parse the response body
        final responseData = await http.Response.fromStream(response);
        final data = json.decode(responseData.body);
        return Account.fromJson(data);
      } else {
        throw Exception("Failed to update avatar: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to update avatar: $e");
    }
  }
}
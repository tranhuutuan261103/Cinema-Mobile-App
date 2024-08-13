// screening_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/cinema.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class ScreeningService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/screenings";

  Future<List<Cinema>> getScreenings({int? provinceId = 1}) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse("$_baseUrl?provinceId=$provinceId"), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Cinema.fromJson(json)).toList();
      } else {
        if (kDebugMode) {
          print("Failed to load cinemas: ${response.statusCode}");
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
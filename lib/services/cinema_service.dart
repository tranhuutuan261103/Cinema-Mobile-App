// cinema_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/cinema.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class CinemaService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/cinemas";

  Future<List<Cinema>> getCinemas() async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse("$_baseUrl?provinceId=2"), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Cinema.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load cinemas");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
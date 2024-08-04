// province_service.dart
import 'dart:convert';

import '../models/province.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class ProvinceService {
  final String _baseUrl = "https://192.168.1.3:44375/provinces";

  Future<List<Province>> getProvinces() async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse(_baseUrl), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Province.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load provinces");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

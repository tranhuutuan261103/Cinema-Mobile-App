// product_combo_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/product_combo.dart';
import '../utils/unsafe_http_helper.dart';

class ProductComboService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/products";

  Future<List<ProductCombo>> getProductCombos() async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse(_baseUrl), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductCombo.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load provinces");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

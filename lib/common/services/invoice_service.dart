// invoice_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/invoice.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class InvoiceService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/invoices";

  Future<List<Invoice>> getInvoices({String? token}) async {
    try {
      final ioClient = getUnsafeIOClient();

      final headers = token != null ? {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        } : {
        "Accept": "application/json",
      };


      final response = await ioClient.get(Uri.parse(_baseUrl), 
        headers: headers
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Invoice.fromJson(json)).toList();
      } else {
        if (kDebugMode) {
          print("Failed to load invoices: ${response.statusCode}");
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
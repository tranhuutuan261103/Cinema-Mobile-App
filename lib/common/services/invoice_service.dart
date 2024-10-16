// invoice_service.dart
import 'dart:convert';
import 'package:cinema_mobile_app/common/models/seat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/invoice.dart';
import '../models/screening.dart';
import '../utils/unsafe_http_helper.dart'; // Update with the correct path

class InvoiceService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/invoices";

  Future<List<Invoice>> getInvoices(String token) async {
    try {
      final ioClient = getUnsafeIOClient();

      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final response =
          await ioClient.get(Uri.parse(_baseUrl), headers: headers);
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

  Future<Invoice> getInvoiceById(String token, int id) async {
    try {
      final ioClient = getUnsafeIOClient();

      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      String url = "$_baseUrl/$id";

      final response =
          await ioClient.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Invoice.fromJson(data);
      } else {
        if (kDebugMode) {
          print("Failed to load invoice: ${response.statusCode}");
        }
        throw Exception("Failed to load invoice");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Invoice> createInvoice(String token, Screening screening, List<Seat> seats) async {
    try {
      final ioClient = getUnsafeIOClient();

      final headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      String url = "$_baseUrl/create";

      final body = json.encode(
        {
          "userId": 0,
          "screeningId": screening.id,
          "seats": seats.map((seat) => {
            "id": seat.id,
            "personTypeId": 1,
          }).toList(),
          "dateOfPurchase": DateTime.now().toIso8601String(),
        }
      );

      final response = await ioClient.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      // If not authorized, return null
      if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      }

      if (response.statusCode == 201) {
        final dynamic data = json.decode(response.body);
        return Invoice.fromJson(data);
      } else {
        if (kDebugMode) {
          print("Failed to create invoice: ${response.statusCode}");
        }
        throw Exception("Failed to create invoice: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}

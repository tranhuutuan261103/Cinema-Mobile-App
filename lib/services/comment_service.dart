// comment_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/comment.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class CommentService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/comments";

  Future<List<Comment>> getComments({int? movieId = 0}) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse("$_baseUrl?movieId=$movieId"), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Comment.fromJson(json)).toList();
      } else {
        if (kDebugMode) {
          print("Failed to load comments: ${response.statusCode}");
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
// comment_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/comment.dart';
import '../utils/unsafe_http_helper.dart'; // Update with the correct path

class CommentService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/comments";

  Future<List<Comment>> getComments({String? token, int? movieId = 0}) async {
    try {
      final ioClient = getUnsafeIOClient();

      final headers = token != null
          ? {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            }
          : {
              "Accept": "application/json",
            };

      final response = await ioClient.get(
          Uri.parse("$_baseUrl?movieId=$movieId&maxSize=10"),
          headers: headers);
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

  Future<Comment> createComment(
      String token, int movieId, String content, int ratingValue) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.post(
        Uri.parse("$_baseUrl/create"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "movieId": movieId,
          "content": content,
          "ratingValue": ratingValue,
        }),
      );
      if (response.statusCode == 200) {
        return Comment.fromJson(json.decode(response.body));
      } else {
        if (kDebugMode) {
          print("Failed to create comment: ${response.statusCode}");
        }
        throw Exception("Failed to create comment");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Failed to create comment");
    }
  }

  Future<void> likeComment(String token, int id) async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.post(
        Uri.parse("$_baseUrl/$id/like"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode != 200) {
        if (kDebugMode) {
          print("Failed to like comment: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

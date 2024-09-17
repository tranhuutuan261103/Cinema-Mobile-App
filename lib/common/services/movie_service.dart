// movie_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/movie.dart';
import '../utils/unsafe_http_helper.dart';

class MovieService {
  final String _baseUrl = "${dotenv.env['API_URL']!}/movies";

  Future<List<Movie>> getMovies() async {
    try {
      final ioClient = getUnsafeIOClient();
      final response = await ioClient.get(
        Uri.parse(_baseUrl),
        headers: {
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        if (kDebugMode) {
          print("Failed to load movies: ${response.statusCode}");
        }
        return Future.error(
            "Failed to load movies. Server responded with status code: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("Network error: $e");
      }
      return Future.error("Network error: Unable to reach the server.");
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Data format error: $e");
      }
      return Future.error("Data format error: Unable to parse response.");
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected error: $e");
      }
      return Future.error("Unexpected error: $e");
    }
  }
}

// movie_service.dart
import 'dart:convert';

import '../models/movie.dart';
import '../utils/unsafe_http_helper.dart';  // Update with the correct path

class MovieService {
  final String _baseUrl = "https://192.168.1.3:44375/movies";

  Future<List<Movie>> getMovies() async {
    try {
      final ioClient = getUnsafeIOClient();

      final response = await ioClient.get(Uri.parse(_baseUrl), 
        headers: {
          "Accept": "application/json",
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
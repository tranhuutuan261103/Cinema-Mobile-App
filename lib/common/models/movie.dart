import './category.dart';
import './screening.dart';

class Movie {
  final int id;
  final String title;
  final String description;
  final String language;
  final String imageUrl;
  final String trailerUrl;
  final String director;
  final String actors;
  final double rating;
  final List<Category> categories;
  final DateTime releaseDate;
  final int duration;
  final List<Screening> screenings;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.imageUrl,
    required this.trailerUrl,
    required this.director,
    required this.actors,
    required this.rating,
    required this.categories,
    required this.releaseDate,
    required this.duration,
    required this.screenings,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var movieImages = json['movieImages'] as List<dynamic>? ?? [];
    
    // Find the poster image, fallback to placeholder if not found
    var posterImage = movieImages.firstWhere(
      (element) => element['imageType'] == 'Poster',
      orElse: () => {'imageUrl': 'https://via.placeholder.com/150'},
    )['imageUrl'] as String;

    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      imageUrl: posterImage,
      trailerUrl: json['trailerUrl'] ?? '',
      director: json['director'] ?? '',
      actors: json['actors'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList(),
      releaseDate: DateTime.now(),
      duration: ((json['duration'] ?? 0) as num).toInt(),
      screenings: json['screenings'] != null
          ? (json['screenings'] as List)
              .map((screening) => Screening.fromJson(screening))
              .toList()
          : [],
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, language: $language, director: $director, actors: $actors, rating: $rating, categories: $categories}';
  }
}
class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final int year;

  Movie({required this.id, required this.title, required this.imageUrl, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      year: json['year'],
    );
  }
}
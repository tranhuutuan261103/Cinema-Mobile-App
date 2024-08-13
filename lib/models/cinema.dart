import './auditorium.dart';

class Cinema {
  final int id;
  final String name;
  final String logoUrl;
  final List<Auditorium> auditoriums;

  Cinema({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.auditoriums,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      auditoriums: (json['auditoriums'] as List<dynamic>)
          .map((auditorium) => Auditorium.fromJson(auditorium))
          .toList(),
    );
  }
}
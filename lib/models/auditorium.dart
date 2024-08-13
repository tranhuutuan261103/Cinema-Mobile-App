import '../models/screening.dart';

class Auditorium {
  final int id;
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  List<Screening> screenings;

  Auditorium({
    required this.id, 
    required this.name, 
    required this.address,
    this.longitude = 0.0,
    this.latitude = 0.0,
    this.screenings = const [],
  });

  factory Auditorium.fromJson(Map<String, dynamic> json) {
    return Auditorium(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      screenings: (json['screenings'] as List<dynamic>)
          .map((screening) => Screening.fromJson(screening))
          .toList(),
    );
  }
}

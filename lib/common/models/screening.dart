import 'package:flutter/material.dart';

import './seat.dart';
import './movie.dart';
import './auditorium.dart';
class Screening {
  final int id;
  final DateTime startDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int seatsAvailable;
  final int seatsTotal;
  final List<Seat>? seats;
  final Movie? movie;
  final Auditorium? auditorium;

  Screening({
    required this.id,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    this.seatsAvailable = 0,
    this.seatsTotal = 0,
    this.seats,
    this.movie,
    this.auditorium,
  });

  factory Screening.fromJson(Map<String, dynamic> json) {
    return Screening(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      startTime: TimeOfDay(
        hour: int.parse(json['startTime'].split(':')[0]),
        minute: int.parse(json['startTime'].split(':')[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(json['endTime'].split(':')[0]),
        minute: int.parse(json['endTime'].split(':')[1]),
      ),
      seatsAvailable: (json['seatsAvailable'] as num).toInt(),
      seatsTotal: (json['seatsTotal'] as num).toInt(),
      seats: json['seats'] != null
          ? (json['seats'] as List).map((seat) => Seat.fromJson(seat)).toList()
          : null,
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
      auditorium: json['auditorium'] != null
          ? Auditorium.fromJson(json['auditorium'])
          : null,
    );
  }
}
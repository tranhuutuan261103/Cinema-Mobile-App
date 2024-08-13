import 'package:flutter/material.dart';

class Screening {
  final int id;
  final DateTime startDate;
  final TimeOfDay startTime;

  Screening({
    required this.id,
    required this.startDate,
    required this.startTime,
  });

  factory Screening.fromJson(Map<String, dynamic> json) {
    return Screening(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      startTime: TimeOfDay(
        hour: int.parse(json['startTime'].split(':')[0]),
        minute: int.parse(json['startTime'].split(':')[1]),
      ),
    );
  }
}
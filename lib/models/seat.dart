import './seat_status.dart';

class Seat {
  final int id;
  final int row;
  final int number;
  final SeatStatus seatStatus;

  Seat({
    required this.id,
    required this.row,
    required this.number,
    required this.seatStatus,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      seatStatus: SeatStatus.fromJson(json['seatStatus']),
    );
  }
}
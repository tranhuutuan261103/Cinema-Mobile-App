import './seat_status.dart';
import './seat_type.dart';

class Seat {
  final int id;
  final int row;
  final int number;
  final SeatStatus seatStatus;
  final SeatType seatType;

  Seat({
    required this.id,
    required this.row,
    required this.number,
    required this.seatStatus,
    required this.seatType,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      seatStatus: SeatStatus.fromJson(json['seatStatus']),
      seatType: SeatType.fromJson(json['seatType']),
    );
  }

  @override
  String toString() {
    return 'Seat{id: $id, row: $row, number: $number, seatStatus: $seatStatus, seatType: $seatType}';
  }
}
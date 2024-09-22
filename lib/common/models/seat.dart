import './seat_status.dart';
import './seat_type.dart';
import './seat_price.dart';

class Seat {
  final int id;
  final int row;
  final int number;
  final SeatStatus seatStatus;
  final SeatType seatType;
  final List<SeatPrice> seatPrices;

  Seat({
    required this.id,
    required this.row,
    required this.number,
    required this.seatStatus,
    required this.seatType,
    this.seatPrices = const [],
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      seatStatus: SeatStatus.fromJson(json['seatStatus']),
      seatType: SeatType.fromJson(json['seatType']),
      seatPrices: (json['prices'] as List).map((seatPrice) => SeatPrice.fromJson(seatPrice)).toList(),
    );
  }

  @override
  String toString() {
    return 'Seat{id: $id, row: $row, number: $number, seatStatus: $seatStatus, seatType: $seatType}';
  }

  String get seatName => String.fromCharCode(65 + row) + number.toString();
}
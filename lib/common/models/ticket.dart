import './screening.dart';
import './seat.dart';

class Ticket {
  final int id;
  final Screening screening;
  final List<Seat> seats;
  final double price;

  Ticket({
    required this.id,
    required this.screening,
    required this.seats,
    required this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      screening: Screening.fromJson(json['screening']),
      seats: (json['seats'] as List<dynamic>).map((seat) => Seat.fromJson(seat)).toList(),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
    };
  }
}
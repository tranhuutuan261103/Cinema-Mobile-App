import './ticket.dart';

class Invoice {
  final int id;
  final Ticket? ticket;
  final double price;
  final double discount;
  final double sumPrice;
  final DateTime dateOfPurchase;

  Invoice({
    required this.id,
    this.ticket,
    required this.price,
    required this.discount,
    required this.sumPrice,
    required this.dateOfPurchase,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      ticket: json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null,
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      sumPrice: (json['sumPrice'] as num).toDouble(),
      dateOfPurchase: DateTime.parse(json['dateOfPurchase']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'discount': discount,
      'sumPrice': sumPrice,
      'dateOfPurchase': dateOfPurchase.toIso8601String(),
    };
  }

  get dateOfPurchaseFormatted {
    return "${dateOfPurchase.day}/${dateOfPurchase.month}/${dateOfPurchase.year} ${dateOfPurchase.hour}:${dateOfPurchase.minute}";
  }
}
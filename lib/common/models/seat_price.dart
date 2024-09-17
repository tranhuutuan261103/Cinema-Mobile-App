class SeatPrice {
  final int seatTypeId;
  final int personTypeId;
  final int price;

  SeatPrice({required this.seatTypeId, required this.personTypeId, this.price = 0});

  factory SeatPrice.fromJson(Map<String, dynamic> json) {
    return SeatPrice(
      seatTypeId: json['seatTypeId'],
      personTypeId: json['personTypeId'],
      price: json['price'],
    );
  }

  @override
  String toString() {
    return 'SeatPrice{seatTypeId: $seatTypeId, personTypeId: $personTypeId, price: $price}';
  }
}
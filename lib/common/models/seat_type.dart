class SeatType {
  final int id;
  final String name;

  SeatType({required this.id, required this.name});

  factory SeatType.fromJson(Map<String, dynamic> json) {
    return SeatType(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'SeatType{id: $id, statusName: $name}';
  }
}
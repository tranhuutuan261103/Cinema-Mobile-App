class SeatStatus {
  final int id;
  final String statusName;
  final bool isAvailable;

  SeatStatus({required this.id, required this.statusName, this.isAvailable = false});

  factory SeatStatus.fromJson(Map<String, dynamic> json) {
    return SeatStatus(
      id: json['id'],
      statusName: json['statusName'],
      isAvailable: json['isAvailable'],
    );
  }

  @override
  String toString() {
    return 'SeatStatus{id: $id, statusName: $statusName, isAvailable: $isAvailable}';
  }
}
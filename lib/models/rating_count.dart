class RatingCount {
  final int value;
  final int count;

  RatingCount({
    required this.value,
    required this.count,
  });

  factory RatingCount.fromJson(Map<String, dynamic> json) {
    return RatingCount(
      value: json['value'],
      count: json['count'],
    );
  }
}
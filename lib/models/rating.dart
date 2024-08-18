class Rating {
  final int movieId;
  final int userId;
  final int value;

  Rating({
    required this.movieId,
    required this.userId,
    required this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      movieId: json['movieId'],
      userId: json['userId'],
      value: json['value'],
    );
  }

  @override
  String toString() {
    switch (value) {
      case 1:
        return 'Kén người mê';
      case 2:
        return 'Kén người mê';
      case 3:
        return 'Chưa ưng lắm';
      case 4:
        return 'Chưa ưng lắm';
      case 5:
        return 'Tạm ổn';
      case 6:
        return 'Tạm ổn';
      case 7:
        return 'Đáng xem';
      case 8:
        return 'Đáng xem';
      case 9:
        return 'Cực phẩm!';
      case 10:
        return 'Cực phẩm!';
      default:
        return 'No rating';
    }
  }
}

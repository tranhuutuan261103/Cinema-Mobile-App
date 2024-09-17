import './account.dart';
import './rating.dart';

class Comment {
  final int id;
  final String content;
  final DateTime createdAt;
  int likes;
  bool isLiked = false;
  final Account author;
  final int movieId;
  final List<Comment> replies;
  final Rating rating;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.likes,
    required this.isLiked,
    required this.author,
    required this.movieId,
    required this.replies,
    required this.rating,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdDate']),
      author: Account.fromJson(json['user']),
      likes: json['likes'],
      isLiked: json['isLiked'],
      movieId: json['movieId'],
      replies: json['replies'] != null
          ? (json['replies'] as List).map((e) => Comment.fromJson(e)).toList()
          : [],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

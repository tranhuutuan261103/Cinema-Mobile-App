import '../models/rating_count.dart';

class RatingHelper {
  int getTotalRating(List<RatingCount> ratings) {
    int count = 0;
    for (var i = 0; i < ratings.length; i++) {
      count += ratings[i].count;
    }
    return count;
  }

  double getAverageRating(List<RatingCount> ratings) {
    if (getTotalRating(ratings) == 0) {
      return 0;
    }
    double total = 0;
    for (var i = 0; i < ratings.length; i++) {
      total += ratings[i].value * ratings[i].count;
    }
    return total / getTotalRating(ratings);
  }

  int getRatingCount(List<RatingCount> ratings, int min, [int max = 10]) {
    try {
      int count = 0;
      for (var i = 0; i < ratings.length; i++) {
        if (ratings[i].value >= min && ratings[i].value <= max) {
          count += ratings[i].count;
        }
      }
      return count;
    } catch (e) {
      return 0;
    }
  }
}
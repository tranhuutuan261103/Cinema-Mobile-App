import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/rating_count.dart';
import '../utils/rating_helper.dart';

class RatingMovieInfo extends StatelessWidget {
  final List<RatingCount> ratings;

  const RatingMovieInfo({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey[300]!,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: colorPrimary),
                    Text(
                      RatingHelper()
                          .getAverageRating(ratings)
                          .toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('/10', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Text('(${RatingHelper().getTotalRating(ratings)} đánh giá)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingRow(9, 10),
                  _buildRatingRow(7, 8),
                  _buildRatingRow(5, 6),
                  _buildRatingRow(3, 4),
                  _buildRatingRow(1, 2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRatingRow(int min, int max) {
    return Row(
      children: [
        SizedBox(
            width: 30,
            child: Text("$min-$max",
                style: const TextStyle(fontSize: 12, height: 1.2))),
        Icon(Icons.star, color: Colors.grey[300], size: 12),
        const SizedBox(width: 12.0),
        Expanded(
          child: LinearProgressIndicator(
            value: RatingHelper().getTotalRating(ratings) == 0
                ? 0
                : RatingHelper().getRatingCount(ratings, min, max) /
                    RatingHelper().getTotalRating(ratings),
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(colorPrimary),
            borderRadius: BorderRadius.circular(5),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

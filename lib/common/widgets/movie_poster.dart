import 'package:flutter/material.dart';
import '../models/movie.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.movie, required this.onTap});

  final Movie movie;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent, // Add a splash color for feedback
      highlightColor: Colors.transparent, // Ensure the highlight color is transparent if needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align the column content to the start
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              height: 240,
              width: 180,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align children to the start
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 4), // Spacing between icon and text
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            width: 180,
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              movie.categories.map((category) => category.name).join(", "),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

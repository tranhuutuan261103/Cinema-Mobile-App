import 'package:flutter/material.dart';

import '../models/movie.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(movie.year.toString()),
      ],
    );
  }
}

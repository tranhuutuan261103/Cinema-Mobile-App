import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TrailerButton extends StatelessWidget {
  const TrailerButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.play_circle_fill,
        color: colorPrimary,
      ),
      label: const Text(
        'Trailer',
        style: TextStyle(
          color: colorPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

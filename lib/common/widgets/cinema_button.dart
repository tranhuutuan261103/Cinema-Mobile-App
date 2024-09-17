import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/cinema.dart';

class CinemaButton extends StatelessWidget {
  final Cinema cinema;
  final bool isSelected;
  final Function onPressed;

  const CinemaButton(
      {super.key, required this.cinema, this.isSelected = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? colorPrimary :Colors.grey, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(
                    8.0), // Optional: Add a border radius if you want rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8.0), // Optional: Apply the same radius if you use a border radius
                child: Image.network(
                  cinema.logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              cinema.name,
              style: TextStyle(
                color: isSelected ? colorPrimary : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AuditoriumSelectionScreen extends StatelessWidget {
  final String title;

  const AuditoriumSelectionScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                  color: Colors.white,
                )),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/city');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: Color.fromARGB(255, 168, 68, 225), // Background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8), // Adjust padding as needed
              ),
              child: const Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the button size fits the content
                children: [
                  Text(
                    "Hà Nội",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 8), // Space between text and icon
                  Icon(Icons.location_city, color: Colors.white), // Icon
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Text("Chọn rạp chiếu"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/booking');
            },
            child: const Text("Chọn rạp chiếu"),
          ),
        ],
      ),
    );
  }
}

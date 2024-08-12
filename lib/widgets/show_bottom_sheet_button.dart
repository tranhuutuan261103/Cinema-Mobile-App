import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ShowBottomSheetButton extends StatelessWidget {
  final String title;
  final Object value;
  final IconData icon;
  final Function() onPressed;

  const ShowBottomSheetButton({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white, // Background color for container
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 24.0, top: 12.0, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(value.toString()),
                      Icon(icon, color: colorPrimary),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 8.0,
            top: -2.0,
            child: Container(
              color: Colors.white, // Match with background to hide overlap
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: colorPrimary, // Adjust color based on your theme
                  backgroundColor: Colors.white, // Ensure text is readable
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

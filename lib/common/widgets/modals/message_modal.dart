import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MessageModal extends StatelessWidget {
  final String title;
  final String message;

  const MessageModal({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: null,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: 250, // Set the maximum width of the dialog
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensures the dialog height fits its content
          children: [
            Text(
              title,
              style: const TextStyle(
                color: colorPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
                colorPrimary.withAlpha(20)),
          ),
          child: const Text('OK',
              style: TextStyle(
                color: colorPrimary,
              )),
        ),
      ],
    );
  }
}
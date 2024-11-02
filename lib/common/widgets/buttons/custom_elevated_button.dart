import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final isDisabled;

  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (!isDisabled) onPressed();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: colorPrimary,
      enableFeedback: false,
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

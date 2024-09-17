import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isObscure = false,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: colorPrimary,
          ),
        ),
      ),
      controller: controller,
      obscureText: isObscure,
    );
  }
}

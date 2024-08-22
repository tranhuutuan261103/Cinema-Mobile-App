import 'package:flutter/material.dart';

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
      ),
      controller: controller,
      obscureText: true,
    );
  }
}

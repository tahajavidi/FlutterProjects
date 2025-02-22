import 'package:flutter/material.dart';

class AdminTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final Widget suffixIcon;
  final bool obscureText;

  const AdminTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.suffixIcon,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        maxLines: null,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

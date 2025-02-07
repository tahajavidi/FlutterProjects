import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String labelText;
  final Widget suffixIcon;
  final bool obscureText;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

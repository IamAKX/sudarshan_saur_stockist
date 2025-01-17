import 'package:flutter/material.dart';

class InputFieldLight extends StatelessWidget {
  const InputFieldLight(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.keyboardType,
      required this.obscure,
      required this.icon,
      this.maxChar,
      this.enabled})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final IconData icon;

  final bool? enabled;
  final int? maxChar;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      keyboardType: keyboardType,
      autocorrect: true,
      maxLength: maxChar,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        prefixIcon: Icon(icon),
      ),
    );
  }
}

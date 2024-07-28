import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Color color;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const FormTextField({
    required this.label,
    this.obscureText = false,
    this.color = Colors.black,
    this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        labelText: label,
        labelStyle: TextStyle(color: color),
      ),
    );
  }
}

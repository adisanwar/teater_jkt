import 'package:flutter/material.dart';

class PaswordForm extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Color color;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onVisibilityToggle;

  const PaswordForm({
    required this.label,
    this.obscureText = false,
    this.color = Colors.black,
    this.controller,
    this.validator,
    this.onChanged,
    this.onVisibilityToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onVisibilityToggle,
        ),
      ),
    );
  }
}

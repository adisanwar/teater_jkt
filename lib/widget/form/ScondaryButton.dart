import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50), // Lebar dan tinggi minimum tombol
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        backgroundColor: Colors.white,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFf96d6d), // Warna teks tombol
          fontSize: 15.0, // Ukuran font
          fontWeight: FontWeight.bold, // Menambahkan ketebalan font
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

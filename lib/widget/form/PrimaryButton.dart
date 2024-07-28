import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String labelbtn;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.onPressed,
    required this.labelbtn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50), // Lebar dan tinggi minimum tombol
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        backgroundColor: const Color(0xFFf96d6d), // Warna latar belakang tombol
      ),
      child: Text(
        labelbtn,
        style: const TextStyle(
          color: Colors.white, // Warna teks tombol
          fontSize: 15.0, // Ukuran font
          fontWeight: FontWeight.bold, // Menambahkan ketebalan font
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

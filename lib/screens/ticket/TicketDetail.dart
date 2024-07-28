import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TicketDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const TicketDetailPage({
    required this.title,
    required this.description,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: BarcodeWidget(
                barcode: Barcode.code128(), // Barcode type and settings
                data: title, // Nama show digunakan sebagai data barcode
                width: 200,
                height: 80,
                drawText: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String status;

  const OrderDetailPage({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
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
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $status',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle order confirmation or other actions
                },
                child: const Text('Confirm Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

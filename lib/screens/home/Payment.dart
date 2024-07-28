import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsPage extends StatelessWidget {
  final String showTitle;
  final String showDescription;
  final String showImageUrl;

  const PaymentDetailsPage({
    required this.showTitle,
    required this.showDescription,
    required this.showImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(showImageUrl),
            const SizedBox(height: 20),
            Text(
              showTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              showDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildPaymentDetail('Ticket Price', 'Rp 150.000'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the payment process
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetail(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }
}

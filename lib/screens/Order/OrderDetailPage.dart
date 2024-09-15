import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';

import '../Booking/PaymentWebview.dart';

class OrderDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String status;
  final String paymentUrl;
  final String orderId;

  const OrderDetailPage({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.paymentUrl,
    required this.orderId,
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
              'Status: $status',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            // Show the Confirm Order button only if the status is "pending"
            if (status.toLowerCase() == 'pending')
              Center(
                child: SizedBox (
                  width: double.infinity,
                  child: PrimaryButton(onPressed: () {
                    Get.to(() => PaymentWebView( paymentUrl: paymentUrl, orderId : orderId));
                  },
                      labelbtn: 'Confirm Order'),
                )
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teater_jkt/controller/order_controller.dart';
import 'package:teater_jkt/controller/show_controller.dart';
import 'dart:convert';

import 'package:teater_jkt/screens/Booking/PaymentWebview.dart';

class PaymentDetailsPage extends StatelessWidget {

  final String showTitle;
  final String showDescription;
  final String showImageUrl;
  final String price;
  final String rating;
  final String location;

   PaymentDetailsPage({
    required this.showTitle,
    required this.showDescription,
    required this.showImageUrl,
    required this.price,
    required this.rating,
    required this.location,
    Key? key,
  }) : super(key: key);

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
            _buildPaymentDetail('Ticket Price', price),
            _buildPaymentDetail('Rating', rating),
            _buildPaymentDetail('Location', location),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _proceedToPayment(context);
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

  Future<void> _proceedToPayment(BuildContext context) async {
    // Logic for handling payment can be added here
    // Example: Navigate to a webview with the payment URL
    String paymentUrl = 'https://example.com/payment'; // Replace with actual payment URL
    Get.to(() => PaymentWebView( url: paymentUrl,));
  }
}

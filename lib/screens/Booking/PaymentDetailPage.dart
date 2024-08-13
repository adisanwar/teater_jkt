import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:teater_jkt/screens/Booking/PaymentWebview.dart';

class PaymentDetailsPage extends StatelessWidget {
  final String showTitle;
  final String showDescription;
  final String showImageUrl;

  const PaymentDetailsPage({
    required this.showTitle,
    required this.showDescription,
    required this.showImageUrl,
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
            _buildPaymentDetail('Ticket Price', 'Rp 150.000'),
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
    try {
      const apiUrl = 'https://api.sandbox.midtrans.com/v2/charge';
      const serverKey = 'SB-Mid-server-GBLLaOsKtweDUxrvJgWMapbK';  // Ganti dengan Server Key Midtrans Anda
      final authHeader = 'Basic ' + base64Encode(utf8.encode(serverKey + ':'));

      final transactionData = {
        "payment_type": "bank_transfer",
        "transaction_details": {
          "order_id": "order-id-${DateTime.now().millisecondsSinceEpoch}",
          "gross_amount": 150000,
        },
        "bank_transfer": {
          "bank": "bca"
        },
        "customer_details": {
          "first_name": "Adit",
          "last_name": "Khannedy",
          "email": "adi@example.com",
          "phone": "08123456789"
        }
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authHeader,
        },
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final paymentUrl = data['redirect_url'];

        print(paymentUrl);

        if (paymentUrl != null) {
          Get.to(() => PaymentWebView(url: paymentUrl));
        } else {
          Get.snackbar('Error', 'Failed to get payment URL');
        }
      } else {
        Get.snackbar('Error', 'Failed to create transaction');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to process payment: $e');
    }
  }
}

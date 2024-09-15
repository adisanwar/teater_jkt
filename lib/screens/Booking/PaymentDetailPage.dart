import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/Booking/PaymentWebview.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';

class PaymentDetailsPage extends StatelessWidget {
  final String showTitle;
  final String showDescription;
  final String showImageUrl;
  final String price;
  final String rating;
  final String location;
  final String paymentUrl;
  final String orderId;

  PaymentDetailsPage({
    required this.showTitle,
    required this.showDescription,
    required this.showImageUrl,
    required this.price,
    required this.rating,
    required this.location,
    required this.paymentUrl,
    required this.orderId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                const SizedBox(height: 80), // Add some space to make sure all content is visible
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white, // Background color to ensure visibility
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                onPressed: () async {
                  await _proceedToPayment(context);
                },
                labelbtn: 'Proses Pembayaran',
              ),
            ),
          ),
        ],
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
    Get.to(() => PaymentWebView(paymentUrl: paymentUrl, orderId: orderId));
  }
}

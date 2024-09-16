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
                // Header Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(showImageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              showDescription,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Payment Details Section
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildPaymentDetail(
                          Icons.attach_money,
                          'Ticket Price',
                          price,
                        ),
                        const Divider(),
                        _buildPaymentDetail(
                          Icons.star,
                          'Rating',
                          rating,
                        ),
                        const Divider(),
                        _buildPaymentDetail(
                          Icons.location_on,
                          'Location',
                          location,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          // Bottom Button Section
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

  Widget _buildPaymentDetail(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }

  Future<void> _proceedToPayment(BuildContext context) async {
    Get.to(() => PaymentWebView(paymentUrl: paymentUrl, orderId: orderId));
  }
}

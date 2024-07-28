import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketBookingPage extends StatelessWidget {
  const TicketBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Tickets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTicketOption('Standard Ticket', 'Rp 50.000', context),
            const SizedBox(height: 10),
            _buildTicketOption('VIP Ticket', 'Rp 100.000', context),
            const SizedBox(height: 10),
            _buildTicketOption('VVIP Ticket', 'Rp 150.000', context),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Get.to(() => const PaymentDetailsPage());
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketOption(String title, String price, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(price),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // Handle adding tickets to cart
        },
      ),
    );
  }
}

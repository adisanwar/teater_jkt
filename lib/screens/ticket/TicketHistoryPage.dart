import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/order_controller.dart';
import 'package:teater_jkt/screens/ticket/TicketDetail.dart';

class TicketHistoryPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket History'),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Assuming you have a way to get the logged-in user's username
        final String currentUsername = 'loggedInUser'; // Replace this with the actual method to get the current username

        // Filter orders to display only those with "Completed" status and matching the logged-in user's username
        final completedOrders = orderController.orders.where((order) {
          final isCompleted = order.status?.toLowerCase() == 'completed';
          final isCurrentUser = order.ticket?.contact?.username == currentUsername;
          return isCompleted && isCurrentUser;
        }).toList();

        if (completedOrders.isEmpty) {
          return const Center(child: Text('No completed ticket history available.'));
        }

        return ListView.builder(
          itemCount: completedOrders.length,
          itemBuilder: (context, index) {
            final order = completedOrders[index];
            final ticketTitle = order.ticket?.show?.title ?? 'No Title';
            final ticketDescription = order.ticket?.show?.description ?? 'No Description';
            final ticketDate = order.ticket?.purchaseDate ?? 'No Date';
            final ticketStatus = order.status ?? 'Unknown';

            return InkWell(
              onTap: () {
                Get.to(() => TicketDetailPage(
                  title: ticketTitle,
                  description: ticketDescription,
                  date: ticketDate,
                ));
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticketTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ticketDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Date: $ticketDate',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Status: $ticketStatus',
                        style: const TextStyle(
                            fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

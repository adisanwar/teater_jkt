import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/ticket_controller.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/screens/ticket/TicketDetail.dart';

class TicketHistoryPage extends StatelessWidget {
  final TicketController ticketController = Get.put(TicketController());
  final ContactController contactController = Get.put(ContactController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket History'),
      ),
      body: Obx(() {
        if (ticketController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Assuming you have a way to get the logged-in user's id or username
        final currentUserId = contactController.contact.value.id; // Replace this with the actual method to get the current user ID

        // Filter tickets to display only those with "Completed" status and matching the logged-in user's id
        final completedTickets = ticketController.tickets.where((ticket) {
          final isCompleted = ticket.status?.toLowerCase() == 'win'; // Adjust the condition as needed
          final isCurrentUser = ticket.contact?.id == currentUserId; // Ensure ticket belongs to the current user
          return isCompleted && isCurrentUser;
        }).toList();

        if (completedTickets.isEmpty) {
          return const Center(child: Text('No completed ticket history available.'));
        }

        return ListView.builder(
          itemCount: completedTickets.length,
          itemBuilder: (context, index) {
            final ticket = completedTickets[index];
            final ticketTitle = ticket.show?.title ?? 'No Title';
            final ticketDescription = ticket.show?.description ?? 'No Description';
            final ticketDate = ticket.purchaseDate ?? 'No Date';
            final ticketStatus = ticket.status ?? 'Unknown';

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

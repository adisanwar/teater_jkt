import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/controller/ticket_controller.dart';
import 'TicketDetail.dart';

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
        if (ticketController.isLoading.value && ticketController.tickets.isEmpty) {
          // Show loading indicator if initially loading and no tickets yet
          return const Center(child: CircularProgressIndicator());
        }

        final tickets = ticketController.tickets;
        final contactId = contactController.contact.value.id;

        // Filter the tickets by contactId and status == "win"
        final filteredTickets = tickets.where((ticket) {
          return ticket.contact?.id == contactId && ticket.status?.toLowerCase() == 'win';
        }).toList();

        if (filteredTickets.isEmpty) {
          return const Center(child: Text('No winning ticket history available.'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            // Call the method to reload ticket data when the user pulls down
            await ticketController.fetchTickets();
          },
          child: ListView.builder(
            itemCount: filteredTickets.length,
            itemBuilder: (context, index) {
              final ticket = filteredTickets[index];
              final seatNumber = ticket.seatNumber ?? 'No Seat';
              final purchaseDate = ticket.purchaseDate ?? 'No Date';
              final status = ticket.status ?? 'Unknown';
              // final contactName = ticket.contact?.fullname ?? 'No Contact';
              final showTitle = ticket.show?.title ?? 'No Show Title';

              return InkWell(
                onTap: () {
                  // Navigate to the TicketDetailPage when a ticket is tapped
                  Get.to(() => TicketDetailPage(
                    title: showTitle,
                    description: 'Seat: $seatNumber'
                        // '\nContact: $contactName'
                        '\nStatus: $status',
                    date: purchaseDate,
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
                          'Seat: $seatNumber',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Purchase Date: $purchaseDate',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Status: Completed',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        // Text(
                        //   'Contact: $contactName',
                        //   style: const TextStyle(fontSize: 16),
                        // ),
                        const SizedBox(height: 10),
                        Text(
                          'Show: $showTitle',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

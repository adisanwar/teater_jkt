import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/controller/ticket_controller.dart';
import 'TicketDetail.dart'; // Assuming you have this page for detailed view of the ticket.

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  final TicketController ticketController = Get.put(TicketController());
  final ContactController contactController = Get.put(ContactController());

  @override
  void initState() {
    super.initState();
    ticketController.fetchTickets(); // Fetch tickets when the screen initializes
    // contactController.fetchContact(); // Fetch contact data if necessary
  }

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

        // Ambil semua tiket yang telah di-fetch
        final tickets = ticketController.tickets;
        final contactId = contactController.contact.value?.id;

        // Pastikan contactId sudah terisi
        if (contactId == null) {
          return const Center(child: Text('No contact found for this user.'));
        }

        // Filter tiket berdasarkan contactId
        final filteredTickets = tickets.where((ticket) {
          return ticket.contactId == contactId;
        }).toList();

        // Jika tiket yang difilter kosong
        if (filteredTickets.isEmpty) {
          return const Center(child: Text('No ticket history available.'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ticketController.fetchTickets(); // Fetch latest tickets
          },
          child: ListView.builder(
            itemCount: filteredTickets.length,
            itemBuilder: (context, index) {
              final ticket = filteredTickets[index];
              final seatNumber = ticket.seatNumber ?? 'No Seat';
              final purchaseDate = ticket.purchaseDate ?? 'No Date';
              final showTitle = ticket.show?.title ?? 'No Show Title';
              final status = ticket.status ?? 'Unknown';

              return InkWell(
                onTap: () {
                  // Navigate to a ticket detail page (if you have one)
                  Get.to(() => TicketDetailPage(
                    title: showTitle,
                    description: 'Seat: $seatNumber\nStatus: $status',
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
                          'Status: $status',
                          style: const TextStyle(fontSize: 16),
                        ),
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

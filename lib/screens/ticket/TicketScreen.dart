import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/ticket/TicketDetail.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final Map<String, List<Map<String, String>>> ticketsByStatus = {
    'On Going': [
      {
        'title': 'Pajama Drive',
        'description': 'A thrilling show with spectacular performances.',
        'date': '2024-07-22',
      },
      {
        'title': 'Another Show',
        'description': 'An amazing show to watch.',
        'date': '2024-07-25',
      },
    ],
    'Pending Payment': [
      {
        'title': 'Boku no Taiyou',
        'description': 'An inspiring and heartwarming show.',
        'date': '2024-08-01',
      },
    ],
    'Sudah Dibayar': [],
    'Riwayat Pembelian': [
      {
        'title': 'Past Show',
        'description': 'A show from the past.',
        'date': '2024-06-15',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tickets'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,

              tabs: [
                Tab(text: '(${ticketsByStatus['On Going']!.length}) On Going'),
                Tab(text: '(${ticketsByStatus['Pending Payment']!.length}) Pending Payment'),
                Tab(text: '(${ticketsByStatus['Sudah Dibayar']!.length}) Sudah Dibayar'),
                Tab(text: '(${ticketsByStatus['Riwayat Pembelian']!.length}) Riwayat Pembelian'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TicketList(tickets: ticketsByStatus['On Going']!),
            TicketList(tickets: ticketsByStatus['Pending Payment']!),
            TicketList(tickets: ticketsByStatus['Sudah Dibayar']!),
            TicketList(tickets: ticketsByStatus['Riwayat Pembelian']!),
          ],
        ),
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  final List<Map<String, String>> tickets;

  const TicketList({required this.tickets, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(() => TicketDetailPage(
              title: tickets[index]['title']!,
              description: tickets[index]['description']!,
              date: tickets[index]['date']!,
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
                    tickets[index]['title']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tickets[index]['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date: ${tickets[index]['date']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

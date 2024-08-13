import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/ticket/TicketDetail.dart';

class TicketHistoryPage extends StatelessWidget {
  final List<Map<String, String>> ticketHistory = [
    {
      'title': 'Pajama Drive',
      'description': 'A thrilling show with spectacular performances.',
      'date': '2024-07-22',
      'status': 'Completed',
    },
    {
      'title': 'Boku no Taiyou',
      'description': 'An inspiring and heartwarming show.',
      'date': '2024-07-15',
      'status': 'Completed',
    },
    {
      'title': 'Tunas di Balik Seragam',
      'description': 'A show full of emotions and incredible performances.',
      'date': '2024-07-10',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket History'),
      ),
      body: ListView.builder(
        itemCount: ticketHistory.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(() => TicketDetailPage(
                title: ticketHistory[index]['title']!,
                description: ticketHistory[index]['description']!,
                date: ticketHistory[index]['date']!,
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
                      ticketHistory[index]['title']!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ticketHistory[index]['description']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Date: ${ticketHistory[index]['date']}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Status: ${ticketHistory[index]['status']}',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

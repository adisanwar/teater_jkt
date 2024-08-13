import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/Order/OrderDetailPage.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Map<String, List<Map<String, String>>> ordersByStatus = {
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
                Tab(text: '(${ordersByStatus['On Going']!.length}) On Going'),
                Tab(text: '(${ordersByStatus['Pending Payment']!.length}) Pending Payment'),
                Tab(text: '(${ordersByStatus['Sudah Dibayar']!.length}) Sudah Dibayar'),
                Tab(text: '(${ordersByStatus['Riwayat Pembelian']!.length}) Riwayat Pembelian'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            OrderList(orders: ordersByStatus['On Going']!),
            OrderList(orders: ordersByStatus['Pending Payment']!),
            OrderList(orders: ordersByStatus['Sudah Dibayar']!),
            OrderList(orders: ordersByStatus['Riwayat Pembelian']!),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Map<String, String>> orders;

  const OrderList({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(() => OrderDetailPage(
              title: orders[index]['title']!,
              description: orders[index]['description']!,
              date: orders[index]['date']!,
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
                    orders[index]['title']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    orders[index]['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date: ${orders[index]['date']}',
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

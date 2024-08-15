import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'package:teater_jkt/screens/Order/OrderDetailPage.dart';
import 'package:teater_jkt/controller/order_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.fetchOrders(); // Fetch orders when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Retrieve the current logged-in username
      final String currentUsername = 'loggedInUser'; // Replace with actual username retrieval method
      // final orderUsername = orderController.order?.ticket?.contact?.username;
      // Group orders by status and filter by the current user's username
      final ordersByStatus = _groupOrdersByStatus(orderController.orders, currentUsername);

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
                  Tab(
                      text:
                          '(${ordersByStatus['Pending Payment']!.length}) Pending Payment'),
                  Tab(
                      text:
                          '(${ordersByStatus['Sudah Dibayar']!.length}) Sudah Dibayar'),
                  Tab(
                      text:
                          '(${ordersByStatus['Riwayat Pembelian']!.length}) Riwayat Pembelian'),
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
    });
  }

  // Group orders by their status and filter by the current user's username
  Map<String, List<Order>> _groupOrdersByStatus(List<Order> orders, String currentUsername) {
    final Map<String, List<Order>> groupedOrders = {
      'On Going': [],
      'Pending Payment': [],
      'Sudah Dibayar': [],
      'Riwayat Pembelian': [],
    };

    for (var order in orders) {
      final orderUsername = order.ticket?.contact?.username; // Assuming 'contact' has a 'username' field

      if (orderUsername == currentUsername) {
        if (order.status == 'On Going') {
          groupedOrders['On Going']!.add(order);
        } else if (order.status == 'pending' || order.status == 'Pending') {
          groupedOrders['Pending Payment']!.add(order);
        } else if (order.status == 'Sudah Dibayar') {
          groupedOrders['Sudah Dibayar']!.add(order);
        } else {
          groupedOrders['Riwayat Pembelian']!.add(order);
        }
      }
    }

    return groupedOrders;
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return InkWell(
          onTap: () {
            Get.to(() => OrderDetailPage(
                  title: order.ticket?.show?.title ?? 'No Title',
                  description:
                      order.ticket?.show?.description ?? 'No Description',
                  date: order.ticket?.purchaseDate ?? 'No Date',
                  status: order.status ?? 'No Status',
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
                    order.ticket?.show?.title ?? 'No Title',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    order.ticket?.show?.description ?? 'No Description',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date: ${order.ticket?.purchaseDate ?? 'No Date'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Status: ${order.status ?? 'No Status'}',
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

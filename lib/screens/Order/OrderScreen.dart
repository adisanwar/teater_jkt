import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/screens/Order/OrderList.dart';
import 'package:teater_jkt/controller/order_controller.dart';
import 'package:teater_jkt/model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = Get.put(OrderController());
  final ContactController contactController = Get.put(ContactController());

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

      var orders = orderController.orders; // Get the list of orders
      final currentContactId = contactController.contact.value.id;

      // Group orders by status and filter by the current user's contact ID
      final ordersByStatus = _groupOrdersByStatus(orders, currentContactId!);

      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('History Order'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: '(${ordersByStatus['Pending Payment']!.length}) Pending Payment'),
                  Tab(text: '(${ordersByStatus['Sudah Dibayar']!.length}) Sudah Dibayar'),
                  Tab(text: '(${ordersByStatus['Dibatalkan']!.length}) Dibatalkan'),
                  Tab(text: '(${ordersByStatus['Riwayat Pembelian']!.length}) Riwayat Pembelian'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              OrderList(orders: ordersByStatus['Pending Payment']!),
              OrderList(orders: ordersByStatus['Sudah Dibayar']!),
              OrderList(orders: ordersByStatus['Dibatalkan']!),
              OrderList(orders: ordersByStatus['Riwayat Pembelian']!),
            ],
          ),
        ),
      );
    });
  }

  Map<String, List<Order>> _groupOrdersByStatus(List<Order> orders, int currentContactId) {
    final Map<String, List<Order>> groupedOrders = {
      'Pending Payment': [],
      'Sudah Dibayar': [],
      'Dibatalkan': [],
      'Riwayat Pembelian': [],
    };

    for (var order in orders) {
      final orderContactId = order.ticket?.contactId;

      if (orderContactId == currentContactId) {
        if (order.status?.toLowerCase() == 'pending') {
          groupedOrders['Pending Payment']!.add(order);
        } else if (order.status?.toLowerCase() == 'paid') {
          groupedOrders['Sudah Dibayar']!.add(order);
        } else if (order.status?.toLowerCase() == 'canceled') {
          groupedOrders['Dibatalkan']!.add(order);
        }

        // Consider other statuses for 'Riwayat Pembelian'
        if (order.status?.toLowerCase() == 'paid' ||
            order.status?.toLowerCase() == 'completed' ||
            order.status?.toLowerCase() == 'canceled'
        ) { // assuming 'completed' is a valid status indicating a past purchase
          groupedOrders['Riwayat Pembelian']!.add(order);
        }
      }
    }

    return groupedOrders;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/order_model.dart';
import 'OrderDetailPage.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({required this.orders, Key? key}) : super(key: key);

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
              description: order.ticket?.show?.description ?? 'No Description',
              date: order.ticket?.purchaseDate ?? 'No Date',
              status: order.status ?? 'No Status',
              paymentUrl : order.paymentUrl ?? 'No Url',
              orderId : order.orderId ?? 'No Order Id'
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Text(
                  //   order.ticket?.show?.description ?? 'No Description',
                  //   style: const TextStyle(fontSize: 16),
                  // ),
                  // const SizedBox(height: 10),
                  Text(
                    'Date: ${order.ticket?.purchaseDate ?? 'No Date'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Status: ${order.status ?? 'No Status'}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
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

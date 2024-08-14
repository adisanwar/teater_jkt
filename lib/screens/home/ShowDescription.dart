import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/ticket_controller.dart';
import 'package:teater_jkt/controller/order_controller.dart';
import 'package:teater_jkt/screens/Booking/PaymentDetailPage.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';
import 'package:teater_jkt/model/order_model.dart'; // Import the OrderModel

class ShowDescriptionPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String rating;
  final String location;
  final int showId;
  final int contactId;

  final TicketController ticketController = Get.put(TicketController());
  final OrderController orderController = Get.put(OrderController());

  ShowDescriptionPage({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.location,
    required this.showId,
    required this.contactId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(imageUrl),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                rating,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location:',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                location,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ticket Price:',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                labelbtn: 'Pesan Tiket',
                onPressed: () async {
                  final ticket = {
                    showId,
                    contactId
                  };
                  final ticketCreated = await ticketController.createTicket(ticket);

                  if (ticketCreated != null) {
                    // Create the order object
                    final order = Data(
                      amount: int.parse(price), // Convert price to int
                      status: 'pending'
                    );

                    await orderController.createOrder(order);

                    if (order != null) {
                      Get.to(
                            () => PaymentDetailsPage(
                          showTitle: title,
                          showDescription: description,
                          showImageUrl: imageUrl,
                          price: price,
                          rating: rating,
                          location: location,
                        ),
                        transition: Transition.rightToLeft,
                      );
                    } else {
                      Get.snackbar('Error', 'Failed to create order');
                    }
                  } else {
                    Get.snackbar('Error', 'Failed to create ticket');
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

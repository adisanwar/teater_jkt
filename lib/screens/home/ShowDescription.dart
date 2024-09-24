import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/ticket_controller.dart';
import 'package:teater_jkt/controller/order_controller.dart';
import 'package:teater_jkt/screens/Booking/PaymentDetailPage.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';
import 'package:teater_jkt/model/order_model.dart';

import '../../model/ticket_model.dart';

class ShowDescriptionPage extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String rating;
  final String location;
  final int showId;
  final int contactId;

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
  _ShowDescriptionPageState createState() => _ShowDescriptionPageState();
}

class _ShowDescriptionPageState extends State<ShowDescriptionPage> {
  final TicketController ticketController = Get.put(TicketController());
  final OrderController orderController = Get.put(OrderController());

  bool _acceptTerms = false; // Manage checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced Image Presentation
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            softWrap: true, // Enable text wrapping
                            overflow: TextOverflow
                                .visible, // Allow overflow to wrap
                          ),
                          const SizedBox(height: 8),
                          // Replace with Star Rating
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                widget.rating,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            softWrap: true,
                            // Enable text wrapping for description
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Location:', widget.location),
                          _buildInfoRow('Ticket Price:', widget.price,
                              isPrice: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I accept the Terms and Conditions',
                        style: TextStyle(fontSize: 16),
                        softWrap: true, // Enable wrapping for this text
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      labelbtn: 'Pesan Tiket',
                      onPressed: () async {
                        if (_acceptTerms) {
                          // Membuat tiket terlebih dahulu
                          final ticket = Ticket(
                            contactId: widget.contactId,
                            showId: widget.showId,
                          );

                          // Gunakan controller untuk membuat tiket
                          final createdTicket =
                          await ticketController.createTicket(ticket);

                          // Convert harga menjadi integer untuk order
                          final int? ticketPrice = int.tryParse(widget.price);

                          if (createdTicket != null) {
                            final order = Order(
                              ticketId: createdTicket.id,
                              amount: ticketPrice,
                            );

                            // Membuat order dan mendapatkan objek order
                            final createdOrder =
                            await orderController.createOrder(order);

                            print(createdOrder.toString());
                            print(createdTicket.toString());
                            // Cek apakah order berhasil dibuat
                            if (createdOrder != null) {
                              final paymentUrl = createdOrder.paymentUrl;
                              final orderId = createdOrder.orderId;

                              // Menampilkan informasi pada konsol untuk debug
                              print('Payment URL: $paymentUrl');
                              print('Order ID: $orderId');

                              // Navigasi ke halaman PaymentDetailsPage
                              Get.to(
                                    () =>
                                    PaymentDetailsPage(
                                      showTitle: widget.title,
                                      showDescription: widget.description,
                                      showImageUrl: widget.imageUrl,
                                      price: widget.price,
                                      rating: widget.rating,
                                      location: widget.location,
                                      paymentUrl: paymentUrl ?? '',
                                      orderId: orderId ?? '',
                                    ),
                                transition: Transition.rightToLeft,
                              );
                            } else {
                              print('error');
                            }
                          } else {
                            print('error');
                          }
                        } else {
                          // Tampilkan snackbar jika checkbox belum dicentang
                          Get.snackbar(
                            'Terms and Conditions',
                            'Please accept the terms and conditions to proceed.',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red[400],
                            colorText: Colors.white,
                          );
                        }
                      },
                    )),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align start of both rows
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 5), // Add some spacing between label and value
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPrice ? Colors.green : Colors.black87,
              ),
              softWrap: true, // Allow text to wrap
              overflow: TextOverflow.visible, // Ensure the text wraps properly
            ),
          ),
        ],
      ),
    );
  }
}


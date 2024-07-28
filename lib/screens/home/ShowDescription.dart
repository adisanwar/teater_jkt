import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/Payment.dart';

class ShowDescriptionPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ShowDescriptionPage({
    required this.title,
    required this.description,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 20),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentDetailsPage(
                          showTitle: title,
                          showDescription: description,
                          showImageUrl: imageUrl,
                        ));
                  },
                  child: const Text('Book Ticket'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

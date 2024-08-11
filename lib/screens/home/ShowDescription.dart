import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/PaymentDetailPage.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';

class ShowDescriptionPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  ShowDescriptionPage({
    required this.title,
    required this.description,
    required this.imageUrl,
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
                  children: [
                    Image.network(imageUrl),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 16),
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
                onPressed: () {
              
                  Get.to(() => PaymentDetailsPage(showTitle: title, showDescription: description, showImageUrl: imageUrl,), transition: Transition.rightToLeft);
                  // // Aksi ketika tombol Pesan Tiket ditekan
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Tiket untuk $title telah dipesan!')),
                  // );
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



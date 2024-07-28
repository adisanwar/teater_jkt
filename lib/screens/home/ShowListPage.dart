import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/ShowDescription.dart';

class ShowsListPage extends StatelessWidget {
  const ShowsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theater Shows'),
      ),
      body: ListView(
        children: [
          _buildShowListItem(
            context,
            'Pajama Drive',
            'A thrilling show with spectacular performances and captivating storytelling.',
            'https://via.placeholder.com/600x400', // Replace with actual image URL
          ),
          _buildShowListItem(
            context,
            'Boku no Taiyou',
            'An inspiring and heartwarming show that touches the soul and mind.',
            'https://via.placeholder.com/600x400', // Replace with actual image URL
          ),
        ],
      ),
    );
  }

  Widget _buildShowListItem(
      BuildContext context, String title, String description, String imageUrl) {
    return ListTile(
      leading: Image.network(imageUrl, width: 100, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        Get.to(() => ShowDescriptionPage(
              title: title,
              description: description,
              imageUrl: imageUrl,
            ));
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:teater_jkt/screens/home/ShowDescription.dart';
//
// class ShowsListPage extends StatelessWidget {
//   const ShowsListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Theater Shows'),
//       ),
//       body: ListView(
//         children: [
//           _buildShowListItem(
//             context,
//             'Pajama Drive',
//             'A thrilling show with spectacular performances and captivating storytelling.',
//             'https://via.placeholder.com/600x400', // Replace with actual image URL
//             'Rp 150.000',
//             '4.8',
//             'Jakarta Theater',
//           ),
//           _buildShowListItem(
//             context,
//             'Boku no Taiyou',
//             'An inspiring and heartwarming show that touches the soul and mind.',
//             'https://via.placeholder.com/600x400', // Replace with actual image URL
//             'Rp 120.000',
//             '4.5',
//             'Bandung Theater',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShowListItem(
//       BuildContext context,
//       String title,
//       String description,
//       String imageUrl,
//       String price,
//       String rating,
//       String location,
//       ) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       child: InkWell(
//         onTap: () {
//           Get.to(() => ShowDescriptionPage(
//             title: title,
//             description: description,
//             imageUrl: imageUrl,
//             price: price,
//             rating: rating,
//             location: location,
//             showId: show,
//           ));
//         },
//         child: Row(
//           children: [
//             Image.network(
//               imageUrl,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       description,
//                       style: const TextStyle(fontSize: 14),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         const Icon(Icons.star, color: Colors.amber, size: 16),
//                         const SizedBox(width: 5),
//                         Text(
//                           rating,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Text(
//                           price,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.green,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       location,
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

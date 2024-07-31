import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/controller/show_controller.dart';
import 'package:teater_jkt/screens/home/ShowDescription.dart';
import 'package:teater_jkt/widget/TPprimaryHeader.dart';

class HomeScreen extends StatelessWidget {
  final ShowController showController = Get.put(ShowController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: WelcomeSection(),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search ...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _CategorySection(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (showController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: showController.shows.map((show) {
                  return CarouselItem(
                    imageUrl: show.photo ?? 'https://via.placeholder.com/600x400',
                    title: show.title ?? 'No Title',
                    description: show.description ?? 'No Description',
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _UpcomingEventsSection(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _TopRatedShowsSection(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}



class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  CarouselItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowDescriptionPage(
              title: title,
              description: description,
              imageUrl: imageUrl,
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class WelcomeSection extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var user = contactController.contact.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            user.firstName ?? 'No Name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    });
  }
}



class _CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Show Favorite',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryItem(title: '#CaraMeminumRamune'),
              CategoryItem(title: '#AturanAntiCinta'),
              CategoryItem(title: '#PajamaDrive'),
              CategoryItem(title: '#Aitakatta'),
              CategoryItem(title: '#TunasDibalikSeragam'),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpcomingEventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            EventItem(title: 'Upcoming Event 1', date: '2024-07-25'),
            EventItem(title: 'Upcoming Event 2', date: '2024-08-01'),
          ],
        ),
      ],
    );
  }
}

class _TopRatedShowsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Rated Shows',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ShowItem(title: 'Top Rated Show 1', rating: '4.9'),
            ShowItem(title: 'Top Rated Show 2', rating: '4.8'),
          ],
        ),
      ],
    );
  }
}



class ShowItem extends StatelessWidget {
  final String title;
  final String rating;

  ShowItem({required this.title, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Rating: $rating',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}


class EventItem extends StatelessWidget {
  final String title;
  final String date;

  EventItem({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}



class CategoryItem extends StatelessWidget {
  final String title;

  CategoryItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}

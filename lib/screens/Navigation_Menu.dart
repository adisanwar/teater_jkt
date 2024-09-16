import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/Home.dart';
import 'package:teater_jkt/screens/home/Profile.dart';
import 'package:teater_jkt/screens/Order/OrderScreen.dart';
import 'package:teater_jkt/screens/ticket/TicketHistoryPage.dart';
import 'package:teater_jkt/controller/navigation_controller.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());
  final PageController _pageController =
      PageController(); // Create a PageController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
            _pageController.jumpToPage(index); // Navigate to the selected page
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.store_mall_directory), label: 'Order'),
            NavigationDestination(
                icon: Icon(Icons.local_mall), label: 'Ticket'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController, // Assign the PageController
        onPageChanged: (index) {
          controller.selectedIndex.value = index; // Update the selected index
        },
        children: controller.screens,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    const OrderScreen(),
    TicketHistoryPage(),
    const ProfilePage()
  ];
}

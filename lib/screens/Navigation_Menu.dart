import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/Home.dart';
import 'package:teater_jkt/screens/home/Profile.dart';
import 'package:teater_jkt/screens/ticket/TicketScreen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar (
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value=index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.airplane_ticket), label: 'Tickets'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          ),
      ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int>  selectedIndex = 0.obs;
  
  final screens = [
    const HomeScreen(), 
    const TicketsScreen(),
    const ProfilePage()
    
  ];
  
}
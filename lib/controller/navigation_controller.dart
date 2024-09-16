import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/screens/home/Home.dart';
import 'package:teater_jkt/screens/home/Profile.dart';
import 'package:teater_jkt/screens/Order/OrderScreen.dart';

import '../screens/ticket/TicketHistoryPage.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    const OrderScreen(),
    TicketHistoryPage(),
    const ProfilePage(),
  ];
}


// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
import 'package:rev_rider/screens/main_app/cart_screen.dart';
import 'package:rev_rider/screens/main_app/home_screen.dart';
import 'package:rev_rider/screens/main_app/profile_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "WELCOME_SCREEN";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSelected = false;
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.black,
        backgroundColor: PrimaryOrangeColor,
        color: Colors.white,
        height: 60,
        index: currentIndex,
        items: [
          Icon(
            Icons.home,
            size: 20,
            color: currentIndex == 0 ? Colors.white : Colors.grey,
          ),
          Icon(
            Icons.card_travel,
            size: 30,
            color: currentIndex == 1 ? Colors.white : Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 20,
            color: currentIndex == 2 ? Colors.white : Colors.grey,
          ),
        ],
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
            print(currentIndex);
          });
        },
      ),
    );
  }
}

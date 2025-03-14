// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rev_rider/screens/admin_panel/admin_add_product.dart';
import 'package:rev_rider/screens/admin_panel/admin_product_list.dart';
import 'package:rev_rider/screens/main_app/cart_screen.dart';
import 'package:rev_rider/screens/main_app/home_screen.dart';
import 'package:rev_rider/screens/main_app/testing.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "WELCOME_SCREEN";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    AdminProductList(),
    CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Profile"),
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

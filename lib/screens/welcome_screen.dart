// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rev_rider/screens/Authentication/login_screen.dart';
import 'package:rev_rider/screens/Authentication/registration_screen.dart';
import 'package:rev_rider/screens/cart_screen.dart';
import 'package:rev_rider/screens/home_screen.dart';
import 'package:rev_rider/screens/profile_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "WELCOME_SCREEN";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    LoginScreen(),
    RegistrationScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[currentIIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Profile"),
        ],
        onTap: (int NewIndex) {
          setState(() {
            currentIIndex = NewIndex;
            print(currentIIndex);
          });
        },
      ),
    );
  }
}

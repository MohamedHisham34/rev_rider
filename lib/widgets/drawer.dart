// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/screens/admin_panel/admin_dashboard.dart';
import 'package:rev_rider/screens/main_app/orders_list.dart';
import 'package:rev_rider/screens/main_app/testing.dart';

Widget appDrawer({required BuildContext context}) {
  final userNumber = authService.currentUser?.email;
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.teal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.teal),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome $userNumber',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);
            // Already on home
          },
        ),
        ListTile(
          leading: Icon(Icons.receipt_long),
          title: Text('My Orders'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrdersList(),
              ),
            ); // Your screen
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.admin_panel_settings),
          title: Text('Admin Panel'),
          onTap: () {
            Navigator.pushNamed(context, AdminDashboard.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.portable_wifi_off),
          title: Text('Login Test'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Testing(),
              ),
            );
          },
        ),
      ],
    ),
  );
}

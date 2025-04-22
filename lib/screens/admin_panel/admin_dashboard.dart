// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rev_rider/screens/admin_panel/admin_add_product.dart';
import 'package:rev_rider/screens/admin_panel/admin_product_list.dart';

class AdminDashboard extends StatelessWidget {
  static const id = "AdminDashboard";
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildHeader(),
              SizedBox(height: 30),
              _buildDashboardOption(
                context,
                title: 'Modify Products',
                icon: Icons.edit,
                color: Colors.blue,
                onTap: () => Navigator.pushNamed(context, AdminProductList.id),
              ),
              SizedBox(height: 20),
              _buildDashboardOption(
                context,
                title: 'Add Product',
                icon: Icons.add_box,
                color: Colors.green,
                onTap: () => Navigator.pushNamed(context, AdminAddProduct.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(Icons.admin_panel_settings, color: Colors.white, size: 50),
          SizedBox(height: 10),
          Text('Welcome, Admin!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 5),
          Text('Manage the product catalog below',
              style: TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildDashboardOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: color,
                  radius: 30,
                  child: Icon(icon, color: Colors.white)),
              SizedBox(width: 20),
              Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

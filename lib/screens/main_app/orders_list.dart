// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/order_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

ProductService _productService = ProductService();

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 4,
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/wing.png'),
          ),
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: db
              .collection("orders")
              .where(OrderModel.firebaseField_orderPlacedBy,
                  isEqualTo: authService.currentUser?.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error loading orders'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No orders found'),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(16, 100, 16, 24),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var orderDoc = snapshot.data!.docs[index];
                Map<String, dynamic> productsData =
                    Map<String, dynamic>.from(orderDoc["productsId"]);
                List<String> productIds = productsData.keys.toList();
                List<int> quantities =
                    productsData.values.map((e) => e as int).toList();

                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #${orderDoc[OrderModel.firebaseField_orderID]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6), // Reduced spacing
                        FutureBuilder<QuerySnapshot>(
                          future: productReference
                              .where(ProductModel.firebaseField_productID,
                                  whereIn: productIds)
                              .get(),
                          builder: (context, productSnapshot) {
                            if (productSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            if (!productSnapshot.hasData) {
                              return Text('Failed to load products');
                            }

                            var productDocs = productSnapshot.data!.docs;

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: productDocs.length,
                              itemBuilder: (context, i) {
                                var product = productDocs[i];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          product[ProductModel
                                              .firebaseField_imageUrl],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product[ProductModel
                                                      .firebaseField_itemName] ??
                                                  'Product Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "Product ID: ${product[ProductModel.firebaseField_productID]}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "x${quantities[i]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Divider(height: 28, thickness: 1),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Total: ₹${orderDoc[OrderModel.firebaseField_orderTotalPrice]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

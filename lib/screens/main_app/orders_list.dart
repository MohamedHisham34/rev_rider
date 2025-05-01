// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/order_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Future<List<OrderWithProducts>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = fetchOrdersWithProducts();
  }

  Future<List<OrderWithProducts>> fetchOrdersWithProducts() async {
    QuerySnapshot orderSnapshot = await db
        .collection("orders")
        .where(OrderModel.firebaseField_orderPlacedBy,
            isEqualTo: authService.currentUser?.uid)
        .get();

    List<OrderWithProducts> ordersList = [];

    for (var orderDoc in orderSnapshot.docs) {
      Map<String, dynamic> productsData = Map<String, dynamic>.from(
          orderDoc[OrderModel.firebaseField_productsIds]);
      List<String> productIds = productsData.keys.toList();

      if (productIds.isEmpty) continue;

      QuerySnapshot productSnapshot = await productReference
          .where(ProductModel.firebaseField_productID, whereIn: productIds)
          .get();

      ordersList.add(
        OrderWithProducts(
          orderDoc: orderDoc,
          products: productSnapshot.docs,
          quantities: productsData.values.toList(),
        ),
      );
    }
    return ordersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<OrderWithProducts>>(
          future: ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error loading orders'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No orders found'));
            }

            var orders = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(16, 100, 16, 24),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                return OrderCard(orderWithProducts: order);
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderWithProducts {
  final DocumentSnapshot orderDoc;
  final List<DocumentSnapshot> products;
  final List<dynamic> quantities;

  OrderWithProducts({
    required this.orderDoc,
    required this.products,
    required this.quantities,
  });
}

class OrderCard extends StatefulWidget {
  final OrderWithProducts orderWithProducts;

  const OrderCard({super.key, required this.orderWithProducts});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    var orderDoc = widget.orderWithProducts.orderDoc;
    var products = widget.orderWithProducts.products;
    var quantities = widget.orderWithProducts.quantities;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(bottom: 20),
      elevation: 8,
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Order #${orderDoc[OrderModel.firebaseField_orderID]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              "Total: ₹${orderDoc[OrderModel.firebaseField_orderTotalPrice]}",
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Column(
              children: products.asMap().entries.map((entry) {
                int i = entry.key;
                var product = entry.value;

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product[ProductModel.firebaseField_imageUrl],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product[ProductModel.firebaseField_itemName] ??
                        'Product Name',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Product ID: ${product[ProductModel.firebaseField_productID]}",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: Text(
                    "x${quantities[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

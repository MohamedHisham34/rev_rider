// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/screens/main_app/order_details_screen.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:rev_rider/widgets/quantity_selector.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  final Stream<QuerySnapshot> cartItem = cartReference.snapshots();
  List<String> _cartProductIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
      ),

      // Builder To Get All Products Id in The Cart Collection
      body: ReusableFutureBuilder(
        future: _cartService.getCartItemsIds(cartProductsIds: _cartProductIds),
        content: (_) {
// StreamBuilder to Get (Quantity,Product Ids)

          return StreamBuilder(
            stream: cartItem,
            builder: (context, cartSnapshot) {
              var cartDocs = cartSnapshot.data?.docs ?? [];

// Get All Products Data From Firebase With User Cart Products Ids
              return StreamBuilder(
                stream: _cartService.cartItemsByProductsIds(
                    productIds: _cartProductIds),
                builder: (context, productSnapshot) {
                  var productsDocs = productSnapshot.data?.docs ?? [];

                  double totalCartPrice = _cartService.calculateTotalPrice(
                    productsDocs: productsDocs,
                    cartDocs: cartDocs,
                  );

                  if (cartDocs.isEmpty || productsDocs.isEmpty) {
                    return Center(child: Text("Your cart is empty."));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartDocs.length,
                          padding: EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final cartItem = cartDocs[index];
                            final cartProductId =
                                cartItem[ProductModel.firebaseField_productID];

                            final matchingProducts = productsDocs
                                .where((doc) => doc.id == cartProductId);

// productsDocs = [
//   { id: "a1", name: "Helmet" },
//   { id: "b2", name: "Gloves" },
//   { id: "c3", name: "Jacket" }
// ];

// cartProductId = "b2";

// final matchingProducts = productsDocs.where((doc) => doc.id == "b2");

//  Output will be an Iterable that contains just this product:
// [{ id: "b2", name: "Gloves" }]

                            if (matchingProducts.isEmpty) {
                              _cartService.removeProductFromCart(cartProductId);
                              return SizedBox.shrink(); // Skip rendering
                            }

                            final productItem = matchingProducts.first;

                            final itemName = productItem[
                                    ProductModel.firebaseField_itemName] ??
                                "Item";
                            final price = (productItem[
                                        ProductModel.firebaseField_price] ??
                                    0)
                                .toDouble();
                            final quantity =
                                cartItem[CartModel.firebaseField_quantity] ?? 1;
                            final imageUrl = productItem[
                                    ProductModel.firebaseField_imageUrl] ??
                                "https://i.postimg.cc/nctPmPQm/logo.png";
                            final total = price * quantity;

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        imageUrl,
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(itemName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          SizedBox(height: 4),
                                          Text(
                                            "Price: ₹${price.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          SizedBox(height: 8),
                                          QuantitySelector(
                                            quantity: quantity,
                                            onPlusTap: () {
                                              // Handle increment
                                            },
                                            onMinusTap: () {
                                              // Handle decrement
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _cartService.removeProductFromCart(
                                                cartProductId);
                                          },
                                          icon: Icon(Icons.delete_outline,
                                              color: Colors.redAccent),
                                        ),
                                        Text(
                                          "₹${total.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "₹${totalCartPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(
                                          cartDocs: cartDocs,
                                          productsDocs: productsDocs,
                                          totalCartPrice: totalCartPrice,
                                        ),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PrimaryOrangeColor,
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text("Proceed to Checkout",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

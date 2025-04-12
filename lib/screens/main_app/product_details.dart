// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/product_model.dart';

import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/quantity_selector.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

// Started quantity
int _quantity = 1;

class ProductDetails extends StatefulWidget {
  final String selectedItemId;
  const ProductDetails({super.key, required this.selectedItemId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
// productService
  ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReusableFutureBuilder(
          future: productService.getSingleProductById(
              selectedItemId: widget.selectedItemId),
          content: (snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Details'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "images/helmet.png",
                  ),

                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  ),
                  Text(
                      "items Name: ${snapshot.data[ProductModel.firebaseField_itemName]} "
                      " description: ${snapshot.data[ProductModel.firebaseField_description]} "
                      " Item Price: ${snapshot.data[ProductModel.firebaseField_price]}"),

                  // Quantity Selector Widget to Adjust Quantity
                  ProductQuantitySelector(),
                  TextButton(
                      onPressed: () {
                        authService.signOut();
                        print(authService.currentUser?.uid);
                      },
                      child: Text("Sign Out Test")),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () async {
                      authService.signedInChecker(context: context);

                      double price = double.parse(
                          "${snapshot.data[ProductModel.firebaseField_price]}");
                      int stock = int.parse(
                          "${snapshot.data[ProductModel.firebaseField_stock]}");

                      CartModel cartModel = CartModel.addProductTCart(
                        quantity: _quantity,
                        productID: "${widget.selectedItemId}",
                      );

                      await db
                          .collection("Users")
                          .doc(authService.currentUser?.uid)
                          .collection('cart')
                          .doc("${widget.selectedItemId}")
                          .set(cartModel.cartInfo());
                    },
                    child: Text("Add To Cart"),
                  )
                ],
              ),
            );
          },
          //Future Builder For Product Details
        ),
      ),
    );
  }
}

class ProductQuantitySelector extends StatefulWidget {
  const ProductQuantitySelector({super.key});

  @override
  State<ProductQuantitySelector> createState() =>
      _ProductQuantitySelectorState();
}

class _ProductQuantitySelectorState extends State<ProductQuantitySelector> {
  @override
  Widget build(BuildContext context) {
    return QuantitySelector(
      quantity: _quantity,
      onPlusTap: () {
        _quantity++;
        setState(() {});
      },
      onMinusTap: () {
        _quantity--;
        setState(() {});
      },
    );
  }
}

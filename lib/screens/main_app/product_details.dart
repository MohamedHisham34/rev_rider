// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
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
  ProductService _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PrimaryGreyColor,
        body: ReusableFutureBuilder(
          future: _productService.getSingleProductById(
              selectedItemId: widget.selectedItemId),
          content: (snapshot) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("images/helmet.png"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            textAlign: TextAlign.start,
                            "${snapshot.data[ProductModel.firebaseField_itemName]}",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              style: TextStyle(fontSize: 20),
                              "${snapshot.data[ProductModel.firebaseField_price]}",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${snapshot.data[ProductModel.firebaseField_description]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ProductQuantitySelector(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            color: PrimaryOrangeColor,
                            onPressed: () async {
                              authService.signedInChecker(context: context);

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

                              print("Product ADDED TO CART");
                            },
                            child: Text(
                              "ADD TO CART",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Text("Delivery on 28 October"),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
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

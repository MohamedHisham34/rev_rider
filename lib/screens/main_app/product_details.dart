// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/quantity_selector.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

int _quantity = 1;

class ProductDetails extends StatefulWidget {
  final String selectedItemId;
  const ProductDetails({super.key, required this.selectedItemId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryGreyColor,
      body: ReusableFutureBuilder(
        future: _productService.getSingleProductById(
            selectedItemId: widget.selectedItemId),
        content: (snapshot) {
          String imageUrl =
              snapshot.data[ProductModel.firebaseField_imageUrl] ??
                  "https://i.postimg.cc/nctPmPQm/logo.png";

          String itemName = snapshot.data
                  .data()
                  .containsKey(ProductModel.firebaseField_itemName)
              ? snapshot.data[ProductModel.firebaseField_itemName] ??
                  "ItemName Got No Data"
              : "Database Error";

          String description = snapshot.data
                  .data()
                  .containsKey(ProductModel.firebaseField_description)
              ? snapshot.data[ProductModel.firebaseField_description] ??
                  "Item Got No Description"
              : "Database Error";

          final price = snapshot.data[ProductModel.firebaseField_price] ?? -1.0;

          bool priceChecker = price == null || price <= 0;

          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    width: 30,
                    image: NetworkImage(imageUrl),
                  ),
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
                          itemName,
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
                            "$price",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(description),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProductQuantitySelector(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          color: priceChecker
                              ? PrimaryGreyColor
                              : PrimaryOrangeColor,
                          onPressed: () async {
                            if (!priceChecker) {
                              authService.signedInChecker(context: context);

                              CartModel cartModel = CartModel.addProductTCart(
                                quantity: _quantity,
                                productID: widget.selectedItemId,
                              );

                              await db
                                  .collection("Users")
                                  .doc(authService.currentUser?.uid)
                                  .collection('cart')
                                  .doc(widget.selectedItemId)
                                  .set(cartModel.cartInfo());

                              print("Product ADDED TO CART");
                            }
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

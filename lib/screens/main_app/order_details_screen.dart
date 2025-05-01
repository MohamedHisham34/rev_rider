// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/order_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:uuid/uuid.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.totalCartPrice,
    required this.productsDocs,
    required this.cartDocs,
  }) : super(key: key);

  final double totalCartPrice;
  final List productsDocs;
  final List cartDocs;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  CartService _cartService = CartService();
  final TextEditingController _addressController = TextEditingController();
  String _selectedPaymentMethod = "Cash on Delivery";
  final uuid = Uuid();

  List<String> _cartProductIds = [];
  List<int> cartProductsQuantity = [];
  // Map<String, int> cartProductsIdsquantity = {};

  getCartIds() async {
    await _cartService.getCartItemsIds(cartProductsIds: _cartProductIds);
    print(_cartProductIds);
  }

  getCartQuantity() async {
    await _cartService.getCartItemsQuantity(
        cartProductsQuantity: cartProductsQuantity);
    print(cartProductsQuantity);
  }

  Map<String, int> assignCartProductsInfoMap() {
    Map<String, int> cartProductsIdsquantity =
        Map.fromIterables(_cartProductIds, cartProductsQuantity);
    print(cartProductsIdsquantity);
    return cartProductsIdsquantity;
  }

  getAllData() async {
    await getCartIds();
    await getCartQuantity();
    await assignCartProductsInfoMap();
  }

  void initState() {
    getAllData();

    super.initState();
  }

  void _placeOrder() async {
    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your delivery address."),
        ),
      );
      return;
    }

    String orderID = uuid.v1();

    OrderModel orderModel = OrderModel(
      productsIds: assignCartProductsInfoMap(),
      orderID: orderID,
      orderTotalPrice: widget.totalCartPrice,
      numberOfItems: widget.cartDocs.length,
      orderAddress: _addressController.text,
      orderState: OrderState.pending,
      orderPlacedBy: authService.currentUser?.uid,
      paymentMethod: _selectedPaymentMethod,
    );

    await db.collection('orders').doc(orderID).set(orderModel.orderInfo());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order placed successfully!")),
    );

    Navigator.pop(context); // Go back to cart or home screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartDocs.length,
                itemBuilder: (context, index) {
                  final cartItem = widget.cartDocs[index];
                  final product = widget.productsDocs[index];

                  final name = product[ProductModel.firebaseField_itemName];
                  final quantity =
                      cartItem[CartModel.firebaseField_quantity] ?? 1;

                  final price = (product[ProductModel.firebaseField_price] ?? 0)
                      .toDouble();
                  final imageUrl = product[ProductModel.firebaseField_imageUrl];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(name,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text("Qty: $quantity"),
                      trailing:
                          Text("₹${(price * quantity).toStringAsFixed(2)}"),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 12),
            // Address Field
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: "Delivery Address",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              maxLines: 2,
            ),

            SizedBox(height: 16),
            // Payment Options
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile<String>(
              title: Text("Cash on Delivery"),
              value: "Cash on Delivery",
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Online Payment"),
              value: "Online Payment",
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),

            Divider(height: 32),

            // Total + Checkout Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ₹${widget.totalCartPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Place Order",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

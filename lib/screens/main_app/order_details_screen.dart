// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/order_model.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:uuid/uuid.dart';

List<String> orderState = ['Delivering', 'Shipping'];

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.totalCartPrice});

  final double totalCartPrice;

  @override
  Widget build(BuildContext context) {
    print('OrderDetailsScreen');
    var uuid = Uuid();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: FutureBuilder(
            future: cartReference.get(),
            builder: (context, snapshot) {
              var docs = snapshot.data?.docs;
              if (snapshot.hasError) {
                return Text("Error Getting documents");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docs[index]['itemName'],
                                textAlign: TextAlign.right,
                              ),
                              Text(docs[index]['productID']),
                              Text(
                                  ' quantity:   ${docs[index]['quantity'].toString()}'),
                              Text(docs[index]['price'].toString()),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "Total Price  ${totalCartPrice.toString()}",
                    style: TextStyle(fontSize: 30),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      var orderID = uuid.v1();

                      OrderModel orderModel = OrderModel(
                          orderID: orderID,
                          orderTotalPrice: totalCartPrice,
                          numberOfItems: docs.length,
                          orderAddress: null,
                          orderState: OrderState.canceled,
                          orderPlacedBy: authService.currentUser?.uid);

                      db
                          .collection('orders')
                          .doc(orderID)
                          .set(orderModel.orderInfo());
                    },
                    child: Text("CHECKOUT"),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/widgets/round_floating_button.dart';

class CartListview extends StatefulWidget {
  CartListview({
    super.key,
    required this.itemCount,
    required this.removeButtonFunction,
    // required this.quantity,
    this.docs,
  });

  final int itemCount;
  final Function removeButtonFunction;
  final List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  State<CartListview> createState() => _CartListviewState();
}

class _CartListviewState extends State<CartListview> {
  CollectionReference cartReference = db
      .collection("Users")
      .doc(authService.currentUser!.uid)
      .collection("cart");

  // final int quantity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        int quantity = widget.docs![index]['quantity'];
        return Card(
          child: Column(
            children: [
              Text(widget.docs?[index]['itemName']),
              Text("${widget.docs?[index]['price'].toString()}"),
              Text("${widget.docs?[index]['quantity'].toString()}"),
              RoundFloatingButton(
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    cartReference
                        .doc(widget.docs![index]['productID'])
                        .update({'quantity': quantity + 1});
                  }),
              RoundFloatingButton(
                  icon: FontAwesomeIcons.minus,
                  onPressed: () {
                    cartReference
                        .doc(widget.docs![index]['productID'])
                        .update({'quantity': quantity - 1});
                  }),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  widget.removeButtonFunction(index);
                },
                child: Text("Remove"),
              ),
            ],
          ),
        );
      },
    );
    ;
  }
}

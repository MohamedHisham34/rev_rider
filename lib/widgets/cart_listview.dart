import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartListview extends StatelessWidget {
  const CartListview({
    super.key,
    required this.itemCount,
    required this.removeButtonFunction,
    this.docs,
  });

  final int itemCount;
  final Function removeButtonFunction;
  final List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Text(docs?[index]['itemName']),
              Text("${docs?[index]['price'].toString()}"),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  removeButtonFunction(index);
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

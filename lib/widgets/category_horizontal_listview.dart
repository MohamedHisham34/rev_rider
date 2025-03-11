// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class CategoryHorizontalListview extends StatelessWidget {
  CategoryHorizontalListview({
    super.key,
    required this.onTap,
    required this.snapshot,
  });
  /////////
  final Function onTap;
  AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data?.docs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              child: Text(
                snapshot.data.docs[index]['name'],
                style: TextStyle(color: Colors.blue),
              ),
              width: 100,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}

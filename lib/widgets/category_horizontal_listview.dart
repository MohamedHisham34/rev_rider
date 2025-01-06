// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class CategoryHorizontalListview extends StatefulWidget {
  const CategoryHorizontalListview({
    super.key,
    required this.itemCount,
    required this.onTap,
    required this.listedCategoryName,
  });
  /////////
  final int itemCount;
  final Function onTap;
  final List listedCategoryName;

  @override
  State<CategoryHorizontalListview> createState() =>
      _CategoryHorizontalListviewState();
}

class _CategoryHorizontalListviewState
    extends State<CategoryHorizontalListview> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              widget.onTap(index);
            },
            child: Container(
              child: Text(
                widget.listedCategoryName[index],
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

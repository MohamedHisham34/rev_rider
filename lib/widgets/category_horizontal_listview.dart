// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:rev_rider/screens/main_app/testing.dart';

class CategoryHorizontalListview extends StatelessWidget {
  CategoryHorizontalListview({
    super.key,
    required this.onTap,
    required this.selectedCategoryIndex,
    required this.itemCount,
    required this.listedCategoryName,
  });
  /////////
  final Function onTap;
  final int itemCount;
  final List listedCategoryName;

  int selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedCategoryIndex == index
                      ? Colors.black
                      : Colors.grey[350]),
              child: Center(
                child: Text(
                  listedCategoryName[index],
                  // snapshot.data.docs[index]['name']

                  style: TextStyle(
                    color: selectedCategoryIndex == index
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              width: 100,
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector(
      {super.key,
      required this.onPlusTap,
      required this.quantity,
      required this.onMinusTap});

  final Function onPlusTap;
  final Function onMinusTap;
  final int quantity;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "${widget.quantity}",
          style: TextStyle(fontSize: 30, backgroundColor: Colors.red),
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          heroTag: 'plus',
          onPressed: () {
            widget.onPlusTap();
            setState(() {});
          },
          child: Icon(FontAwesomeIcons.plus),
        ),
        FloatingActionButton(
          heroTag: 'minus',
          onPressed: () {
            widget.onMinusTap();
            setState(() {});
          },
          child: Icon(FontAwesomeIcons.minus),
        )
      ],
    );
  }
}

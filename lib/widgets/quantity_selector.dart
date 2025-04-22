import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    Key? key,
    required this.onPlusTap,
    required this.quantity,
    required this.onMinusTap,
  }) : super(key: key);

  final VoidCallback onPlusTap;
  final VoidCallback onMinusTap;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onMinusTap,
            icon: Icon(FontAwesomeIcons.minus, size: 14),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "$quantity",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: onPlusTap,
            icon: Icon(FontAwesomeIcons.plus, size: 14),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

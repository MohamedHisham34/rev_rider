import 'package:flutter/material.dart';

class RoundFloatingButton extends StatelessWidget {
  const RoundFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.grey,
        shape: const CircleBorder(),
        child: Icon(icon),
        onPressed: () {
          onPressed();
        });
  }
}

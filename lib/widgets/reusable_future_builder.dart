// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ReusableFutureBuilder extends StatelessWidget {
  const ReusableFutureBuilder(
      {super.key, required this.future, required this.content});

  final future;
  final Widget Function(AsyncSnapshot snapshot) content;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error Getting documents");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return content(snapshot);
      },
    );
  }
}

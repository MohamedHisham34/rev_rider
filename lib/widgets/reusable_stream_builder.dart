import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReusableStreamBuilder extends StatelessWidget {
  const ReusableStreamBuilder(
      {super.key, required this.stream, required this.content});

  final Stream<QuerySnapshot> stream;
  final Widget Function(AsyncSnapshot<QuerySnapshot> snapshot) content;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error Getting documents");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }

        return content(snapshot);
      },
    );
  }
}

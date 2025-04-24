import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authService.signedInChecker(context: context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: Scaffold(
          appBar: AppBar(
            title: const Text('Profile Screen'),
          ),
          body: Container(),
        ));
  }
}

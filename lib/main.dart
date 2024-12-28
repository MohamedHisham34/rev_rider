// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/firebase_options.dart';
import 'package:rev_rider/screens/home_screen.dart';
import 'package:rev_rider/screens/welcome_screen.dart';
import 'package:rev_rider/services/auth_service.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth uAuth = FirebaseAuth.instance;
AuthService authService = AuthService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("Database Connected");
          }
          if (snapshot.hasError) {
            return Text("Error");
          }
          return Text("Loading");
        },
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}

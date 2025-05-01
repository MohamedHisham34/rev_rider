// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/firebase_options.dart';
import 'package:rev_rider/screens/admin_panel/admin_add_product.dart';
import 'package:rev_rider/screens/admin_panel/admin_dashboard.dart';
import 'package:rev_rider/screens/admin_panel/admin_product_list.dart';
import 'package:rev_rider/screens/authentication/login_screen.dart';
import 'package:rev_rider/screens/authentication/registration_screen.dart';
import 'package:rev_rider/screens/main_app/home_screen.dart';
import 'package:rev_rider/screens/main_app/welcome_screen.dart';
import 'package:rev_rider/services/auth_service.dart';
import 'package:rev_rider/services/firestore_service.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth uAuth = FirebaseAuth.instance;
FirestoreService firestoreService = FirestoreService();

AuthService authService = AuthService();

void returnToPerviousScreen({required BuildContext context}) {
  Navigator.pop(context);
  Navigator.pop(context);
}

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
      debugShowCheckedModeBanner: false,
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
        //Bottom Navigation
        WelcomeScreen.id: (context) => WelcomeScreen(),
        //Main Application
        HomeScreen.id: (context) => HomeScreen(),
        // Login And Register
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),

        // Admin
        AdminDashboard.id: (context) => AdminDashboard(),
        AdminProductList.id: (context) => AdminProductList(),
        AdminAddProduct.id: (context) => AdminAddProduct(),
      },
    );
  }
}

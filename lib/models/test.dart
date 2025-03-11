// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';

class Test {
  static const String FirebaseField_Name = 'name';
  static const String FirebaseField_age = 'age';
  static const String FirebaseField_gender = 'gender';

  final String name;
  final String age;
  final String gender;

  Test({required this.name, required this.age, required this.gender});

  Map<String, dynamic> testInfo() {
    return {
      FirebaseField_Name: name,
      FirebaseField_age: age,
      FirebaseField_gender: gender
    };
  }
}

import 'package:flutter/material.dart';

class FirestoreService {
  /// Generic function to safely get a value from Firestore
  T? getFieldValue<T>({
    required AsyncSnapshot snapshot,
    required String field,
    int? index,
  }) {
    try {
      if (snapshot.data == null) return null;

      Map<String, dynamic>? data;

      if (snapshot.data is List) {
        // Not expected, but just in case
        return null;
      }

      // Handle QuerySnapshot (e.g., list of docs)
      if (snapshot.data?.docs != null) {
        final doc = snapshot.data?.docs[index ?? 0];
        data = doc?.data() as Map<String, dynamic>?;
      } else {
        // Handle DocumentSnapshot (single document)
        data = snapshot.data?.data() as Map<String, dynamic>?;
      }

      if (data == null || !data.containsKey(field)) {
        debugPrint("Field '$field' not found.");
        return null;
      }

      final value = data[field];
      if (value is T) {
        return value;
      } else {
        debugPrint(
            " Field '$field' is not of expected type '${T.runtimeType}' (actual: ${value.runtimeType}).");
        return null;
      }
    } catch (e) {
      debugPrint("Error accessing field '$field': $e");
      return null;
    }
  }

  String testingString({
    required AsyncSnapshot snapshot,
    required String firebaseField,
    int? index,
  }) {
    return getFieldValue<String>(
          snapshot: snapshot,
          field: firebaseField,
          index: index,
        ) ??
        "$firebaseField Got No Data";
  }

  double testingDoubles({
    required AsyncSnapshot snapshot,
    required String firebaseField,
    int? index,
  }) {
    return getFieldValue<double>(
          snapshot: snapshot,
          field: firebaseField,
          index: index,
        ) ??
        -1.0;
  }
}

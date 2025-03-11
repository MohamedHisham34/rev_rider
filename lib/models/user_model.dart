// ignore_for_file: constant_identifier_names

class UserModel {
  static const String firebaseField_userEmail = 'userEmail';
  static const String firebaseField_phoneNumber = 'phoneNumber';
  static const String firebaseField_userID = 'userID';
  final String? userID;
  final String? userEmail;
  final String? phoneNumber;

  UserModel({
    required this.userEmail,
    required this.phoneNumber,
    required this.userID,
  });

  Map<String, dynamic> userCredential() {
    return {
      firebaseField_userEmail: userEmail,
      firebaseField_phoneNumber: phoneNumber,
      firebaseField_userID: userID
    };
  }
}

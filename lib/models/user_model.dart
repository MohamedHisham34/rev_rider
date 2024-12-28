class UserModel {
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
      "userEmail": userEmail,
      "phoneNumber": phoneNumber,
      "userID": userID
    };
  }
}

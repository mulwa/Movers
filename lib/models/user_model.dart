import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;

  UserModel(
      {required this.fullName,
      required this.emailAddress,
      required this.phoneNumber});

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        fullName: snapshot['name'],
        emailAddress: snapshot['emailAddress'],
        phoneNumber: snapshot['phoneNumber']);
  }
}

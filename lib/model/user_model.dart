import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String email;
  final String uid;
  final bool isVendor;

  UserModel(
      {required this.email,
      required this.isVendor,
      required this.uid,});

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "is_vendor": isVendor,
      };

  static UserModel? fromSnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      isVendor: snapshot['is_vendor'],
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }
}
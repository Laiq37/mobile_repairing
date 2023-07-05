import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mobile_repairing/model/user_model.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  bool isEmailValid(String email) {
  RegExp regExp =  RegExp( r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  return regExp.hasMatch(email);
}

  logout()async{
    await _auth.signOut().then((value) => Get.offAllNamed(RoutesNames.LoginScreen));
  }

  Future<String> signUpUser(
     String email,
     String password,
     bool isVendor,
     [role]
  ) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(user.user!.uid);

        UserModel userModel = UserModel(
          email: email,
          uid: user.user!.uid,
          isVendor: isVendor,
        );

        await _firestore.collection('users').doc(user.user!.uid).set(
              {...userModel.toJson(),'vendor_type':role},
            );
        result = 'success';
        print("Success firestore");
      }
    } catch (err) {
      result = err.toString();
      print("Error firestore == $err");
    }
    return result;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<void> checkIfVendor([String? email]) async{
      var userDocs = await _firestore
    .collection('users')
    .where('email', isEqualTo: email ?? _auth.currentUser!.email)
    .where('is_vendor', isEqualTo: true)
    .get();
    if(userDocs.docs.isEmpty)
    {
      Get.offAllNamed(RoutesNames.SelectServiceScreen);
      return;
    }
    var vendorType = userDocs.docs[0].data()["vendor_type"];
    Get.offAllNamed(RoutesNames.CurrentOrdersScreen,arguments: vendorType
    );
  }
}
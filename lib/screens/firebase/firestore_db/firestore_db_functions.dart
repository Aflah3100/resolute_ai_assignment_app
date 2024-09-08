import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resolute_ai_assignment_app/models/user_model.dart';

class FirestoreDbFunctions {
  FirestoreDbFunctions._internal();
  static FirestoreDbFunctions instance = FirestoreDbFunctions._internal();
  factory FirestoreDbFunctions() => instance;

  static const String userCollection = 'users';

  //Save-user-details-to-firestore

  Future<dynamic> saveUserModel({required UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userModel.mobileNo)
          .set(userModel.toJson());
      return true;
    } on FirebaseException catch (e) {
      return e.code;
    } catch (e) {
      return e;
    }
  }

  //Get-User-Details-using-email
  Future<UserModel?> getUserInfobyEmail({required String email}) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(userCollection)
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        //User-found
        final userData = querySnapshot.docs.first.data();
        final userModel = UserModel.fromJson(userData);

        return userModel;
      } else {
        //no-user-found
        return null;
      }
    } catch (e) {
      debugPrint("Error getting user details");
    }
    return null;
  }
}

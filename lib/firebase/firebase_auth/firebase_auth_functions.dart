import 'package:firebase_auth/firebase_auth.dart';
import 'package:resolute_ai_assignment_app/models/user_model.dart';
import 'package:resolute_ai_assignment_app/firebase/firestore_db/firestore_db_functions.dart';

class FirebaseAuthFunctions {
  FirebaseAuthFunctions._internal();
  static FirebaseAuthFunctions instance = FirebaseAuthFunctions._internal();
  factory FirebaseAuthFunctions() => instance;

  Future<dynamic> registerNewUserUsingEmail(
      {required UserModel userModel, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.emailId, password: password);

      User? currentUser = userCredential.user;

      if (currentUser != null) {
        //Profile-update
        await currentUser.updateProfile(displayName: userModel.fullName);

        //Save data-to-firebase
        final result = await FirestoreDbFunctions.instance
            .saveUserModel(userModel: userModel);

        if (result is bool) {
          //Success
          return true;
        } else if (result is String) {
          //Failed-saving-user-data
          return result;
        }
      } else {
        //Failed-authenticating-user
        return FirebaseAuthException(code: 'Error Registering New User!').code;
      }
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

  Future<dynamic> authenticateUserUsingEmail(
      {required String emailId, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailId, password: password);
      User? currentUser = userCredential.user;

      if (currentUser != null) {
        UserModel? userModel = await FirestoreDbFunctions.instance
            .getUserInfobyEmail(email: emailId);

        if (userModel != null) {
          //Sucess
          return userModel;
        }
      } else {
        //Failed-signing-in
        return FirebaseAuthException(code: "Error Signing In!").code;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      } else {
        return ('Error Signing In! : ${e.message}');
      }
    } on FirebaseException catch (e) {
      //Error
      return e;
    }
  }

  //Reset-Password-By-Registered-Email-Address
  Future<dynamic> resetPasswordUsingEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Sign-out-user-from-firebase
  Future<dynamic> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resolute_ai_assignment_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._internal();
  static SharedPrefs instance = SharedPrefs._internal();
  factory SharedPrefs() => instance;

  final String userKey = 'logged-user';

  Future<void> saveUserModel(UserModel userModel) async {
    try {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

      String userJson = jsonEncode(userModel.toJson());

      await sharedPrefs.setString(userKey, userJson);

      print("Get status: ${await getSavedUserModel()}");
    } catch (e) {
      debugPrint("Shared preferences error : $e");
    }
  }

  Future<UserModel?> getSavedUserModel() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    String? userJson = sharedPrefs.getString(userKey);

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }

    return null;
  }

  Future<void> deleteSavedUser() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove(userKey);
  }
}

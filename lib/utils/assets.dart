import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Assets {
  static const loginAnimation = 'assets/animations/login_animation.json';
  static const forgotPasswordImage = 'assets/images/forgot_password.jpg';
}

class AppColors {
  static const darkBlueColor = Color(0xff2067BD);
  static const lightBlueColor = Color(0xff4A8FE2);
}

class AppTextStyles {
  static TextStyle appTextStyle(
      {double? fontSize, required Color fontColor, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: fontColor, fontWeight: fontWeight);
  }
}

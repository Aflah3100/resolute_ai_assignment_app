import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:resolute_ai_assignment_app/screens/new_user_regrn_screen/new_user_regrn_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/otp_verification_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/phone_number_verification_screen.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/user_profile_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthenticationScreen.routeName:
      return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
    case PhoneNumberVerificationScreen.routeName:
      return MaterialPageRoute(builder: (_) => PhoneNumberVerificationScreen());
    case OtpVerificationScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        final args = routeSettings.arguments as List;
        final phoneNumber = args[0] as String;
        final verificationId = args[1] as String;
        return OtpVerificationScreen(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
        );
      });
    case NewUserRegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        final registeredMobileNumber = routeSettings.arguments as String;
        return NewUserRegisterScreen(
            registeredMobileNumber: registeredMobileNumber);
      });
    case UserProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const UserProfileScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text(
                    'Screen Does not exist!',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ));
  }
}

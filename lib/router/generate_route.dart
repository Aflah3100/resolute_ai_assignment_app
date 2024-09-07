import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:resolute_ai_assignment_app/screens/new_user_regrn_screen/new_user_regrn_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/otp_verification_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/phone_number_verification_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthenticationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case PhoneNumberVerificationScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const PhoneNumberVerificationScreen());
    case OtpVerificationScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        final phoneNumber = routeSettings.arguments as String;
        return OtpVerificationScreen(phoneNumber: phoneNumber);
      });
    case NewUserRegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        final registeredMobileNumber = routeSettings.arguments as String;
        return NewUserRegisterScreen(
            registeredMobileNumber: registeredMobileNumber);
      });
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

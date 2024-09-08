// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = RouteConstants.forgotPasswordScreen;
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Material(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Image.asset(Assets.forgotPasswordImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Forgot\nPassword?',
                    style: AppTextStyles.appTextStyle(
                        fontColor: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        'Don\'t worry it happens. Please enter the email id associated with your account.',
                        style: AppTextStyles.appTextStyle(
                            fontColor: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password reset link will be sent to email if registered.',
                        style: AppTextStyles.appTextStyle(
                            fontColor: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                        hintText: 'Email ID',
                        hintStyle:
                            AppTextStyles.appTextStyle(fontColor: Colors.grey),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.at,
                          color: Colors.grey,
                          size: 20,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                AuthenticationButton(
                    label: 'Submit',
                    onTap: () async {
                      if (emailController.text.isEmpty) {
                        showErrorToast('Enter email id');
                      } else if (!isValidEmail(emailController.text)) {
                        showErrorToast('Enter valid email');
                      } else {
                        final authResult = await FirebaseAuthFunctions.instance
                            .resetPasswordUsingEmail(
                                email: emailController.text);
                        if (authResult is bool) {
                          //Link-send
                          Fluttertoast.showToast(
                              msg: 'Password reset link sent.',
                              textColor: Colors.white,
                              backgroundColor: Colors.green,
                              gravity: ToastGravity.CENTER);
                          Navigator.pop(context);
                        } else if (authResult is String) {
                          showErrorToast(authResult);
                        }
                      }
                    },
                    buttonColor: AppColors.darkBlueColor,
                    textColor: Colors.white)
              ],
            ),
          ),
        ),
      )),
    );
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }
}

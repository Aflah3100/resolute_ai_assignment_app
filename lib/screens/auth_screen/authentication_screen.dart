// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resolute_ai_assignment_app/models/user_model.dart';
import 'package:resolute_ai_assignment_app/providers/auth_scren_provider.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:resolute_ai_assignment_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/phone_number_verification_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = RouteConstants.authenticationScreen;
  AuthenticationScreen({super.key});

  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();

  //keys
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final authScreenProvider = context.read<AuthScrenProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Material(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Login-animation
                Center(
                  child: SizedBox(
                    height: height * 0.4,
                    child: Lottie.asset(
                      Assets.loginAnimation,
                      fit: BoxFit.contain,
                      reverse: true,
                      repeat: false,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Screen-items
                Selector<AuthScrenProvider, bool>(
                    selector: (context, provider) => provider.isLoginMode(),
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Heading-text
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              (!authScreenProvider.isLoginMode())
                                  ? 'Sign up'
                                  : 'Login',
                              style: AppTextStyles.appTextStyle(
                                  fontColor: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //Login-text-fields-container
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                //Name-textfield
                                if (!authScreenProvider.isLoginMode()) ...[
                                  TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1.0),
                                        ),
                                        hintText: 'Full Name',
                                        hintStyle: AppTextStyles.appTextStyle(
                                            fontColor: Colors.grey),
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.user,
                                          color: Colors.grey,
                                          size: 20,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],

                                //email-textfield
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 1.0),
                                      ),
                                      hintText: 'Email ID',
                                      hintStyle: AppTextStyles.appTextStyle(
                                          fontColor: Colors.grey),
                                      prefixIcon: const Icon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //mobileno-textfield
                                if (!authScreenProvider.isLoginMode()) ...[
                                  TextFormField(
                                    controller: mobileController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1.0),
                                        ),
                                        hintText: 'Mobile',
                                        hintStyle: AppTextStyles.appTextStyle(
                                            fontColor: Colors.grey),
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.phone,
                                          color: Colors.grey,
                                          size: 20,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                                //password-textfield
                                Selector<AuthScrenProvider, bool>(
                                    selector: (context, provider) =>
                                        provider.isPasswordVisible(),
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: (authScreenProvider
                                                .isPasswordVisible())
                                            ? false
                                            : true,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300]!,
                                                  width: 1.0),
                                            ),
                                            hintText: 'Password',
                                            hintStyle:
                                                AppTextStyles.appTextStyle(
                                                    fontColor: Colors.grey),
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.lock,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  authScreenProvider
                                                      .setIsPasswordVisible(
                                                          !authScreenProvider
                                                              .isPasswordVisible());
                                                },
                                                icon: Icon(
                                                  (authScreenProvider
                                                          .isPasswordVisible())
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.grey,
                                                ))),
                                      );
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                //forgot-password-text
                                if (authScreenProvider.isLoginMode())
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          //Forgot-Password-Screen
                                          Navigator.pushNamed(context,
                                              ForgotPasswordScreen.routeName);
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: AppTextStyles.appTextStyle(
                                              fontSize: 17,
                                              fontColor:
                                                  AppColors.darkBlueColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                //confirm-password-textfield
                                if (!authScreenProvider.isLoginMode()) ...[
                                  TextFormField(
                                    controller: confirmPasswordcontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1.0),
                                        ),
                                        hintText: 'Confirm Password',
                                        hintStyle: AppTextStyles.appTextStyle(
                                            fontColor: Colors.grey),
                                        prefixIcon: const Icon(
                                          Icons.password,
                                          color: Colors.grey,
                                          size: 20,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                                if (!authScreenProvider.isLoginMode())
                                  Wrap(
                                    children: [
                                      Text(
                                        'By Signing up you\'re agree to our ',
                                        style: AppTextStyles.appTextStyle(
                                            fontColor: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Terms & Conditions ',
                                        style: AppTextStyles.appTextStyle(
                                            fontColor: AppColors.darkBlueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'and ',
                                        style: AppTextStyles.appTextStyle(
                                            fontColor: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Privacy Policy',
                                        style: AppTextStyles.appTextStyle(
                                            fontColor: AppColors.darkBlueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                          if (!authScreenProvider.isLoginMode())
                            //Continue Button
                            Selector<AuthScrenProvider, bool>(
                                selector: (context, provider) =>
                                    provider.isLoading(),
                                builder: (context, isLoading, child) {
                                  return AuthenticationButton(
                                    label: 'Continue',
                                    onTap: () async {
                                      if (isLoading) return;

                                      authScreenProvider.setLoadingStatus(true);
                                      //Register-user

                                      try {
                                        if (verifySignUpDetails()) {
                                          final userModel = UserModel(
                                              fullName: nameController.text,
                                              emailId: emailController.text,
                                              mobileNo: mobileController.text);
                                          final authResult =
                                              await FirebaseAuthFunctions
                                                  .instance
                                                  .registerNewUserUsingEmail(
                                                      userModel: userModel,
                                                      password:
                                                          passwordController
                                                              .text);
                                          if (authResult is bool) {
                                            //Authentication Sucess
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (_) =>
                                            //             HomeScreen()));
                                          } else if (authResult is String) {
                                            showErrorToast(authResult);
                                          }
                                        }
                                      } catch (e) {
                                        showErrorToast('Error Signing Up');
                                      } finally {
                                        authScreenProvider
                                            .setLoadingStatus(false);
                                      }
                                    },
                                    buttonColor: AppColors.lightBlueColor,
                                    textColor: Colors.white,
                                    isLoading: isLoading,
                                    loadingColor: Colors.white,
                                  );
                                }),
                          if (authScreenProvider.isLoginMode())
                            //Login Button
                            Selector<AuthScrenProvider, bool>(
                                selector: (context, provider) =>
                                    provider.isLoading(),
                                builder: (context, isLoading, child) {
                                  return AuthenticationButton(
                                    label: 'Login',
                                    onTap: () async {
                                      if (isLoading) return;

                                      authScreenProvider.setLoadingStatus(true);

                                      try {
                                        //Sign-in-User
                                        if (verifySigninDetails()) {
                                          //Sign-in-user
                                          final authResult =
                                              await FirebaseAuthFunctions
                                                  .instance
                                                  .authenticateUserUsingEmail(
                                                      emailId:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text);
                                          if (authResult is UserModel) {
                                            //signin-succes
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (_) =>
                                            //             HomeScreen()));
                                          } else if (authResult
                                              is FirebaseAuthException) {
                                            showErrorToast(authResult.message ??
                                                'Error Signing In');
                                          } else if (authResult is String) {
                                            showErrorToast(authResult);
                                          }
                                        }
                                      } catch (e) {
                                        showErrorToast('Error Signing in!');
                                      } finally {
                                        authScreenProvider
                                            .setLoadingStatus(false);
                                      }
                                    },
                                    buttonColor: AppColors.lightBlueColor,
                                    textColor: Colors.white,
                                    isLoading: isLoading,
                                    loadingColor: Colors.white,
                                  );
                                }),
                          const SizedBox(
                            height: 20,
                          ),

                          if (authScreenProvider.isLoginMode()) ...[
                            //Divider-Stack
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Stack(
                                children: [
                                  const Divider(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        width: 70,
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                          'OR',
                                          style: AppTextStyles.appTextStyle(
                                              fontSize: 15,
                                              fontColor: Colors.grey[600]!,
                                              fontWeight: FontWeight.w600),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Login-withh-otp
                            AuthenticationButton(
                              label: 'Login With Otp',
                              icon: const Icon(
                                FontAwesomeIcons.phone,
                                color: AppColors.darkBlueColor,
                              ),
                              onTap: () {
                                //Phone-number-verification-screen
                                Navigator.pushNamed(context,
                                    PhoneNumberVerificationScreen.routeName);
                              },
                              buttonColor: Colors.grey[100]!,
                              textColor: Colors.grey[600]!,
                              isLoading: false,
                              loadingColor: Colors.grey[600]!,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],

                          //Login/Signup-text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (!authScreenProvider.isLoginMode())
                                    ? 'Joined us before?  '
                                    : 'New to the App? ',
                                style: AppTextStyles.appTextStyle(
                                    fontSize: 17,
                                    fontColor: Colors.grey[800]!,
                                    fontWeight: FontWeight.w400),
                              ),
                              //Login-text-button
                              GestureDetector(
                                onTap: () {
                                  authScreenProvider.setLogin(
                                      !(authScreenProvider.isLoginMode()));
                                },
                                child: Text(
                                  (!authScreenProvider.isLoginMode())
                                      ? 'Login'
                                      : 'Sign up',
                                  style: AppTextStyles.appTextStyle(
                                      fontSize: 17,
                                      fontColor: AppColors.darkBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool verifySigninDetails() {
    if (emailController.text.isEmpty) {
      showErrorToast('Email id can\'t be empty');
      return false;
    } else if (!isValidEmail(emailController.text)) {
      showErrorToast('Enter valid email address');
      return false;
    } else if (passwordController.text.isEmpty) {
      showErrorToast('Please enter your password');
      return false;
    } else {
      return true;
    }
  }

  bool verifySignUpDetails() {
    if (nameController.text.isEmpty) {
      showErrorToast('Name can\'t be empty');
      return false;
    } else if (nameController.text.length < 5) {
      showErrorToast('Enter a valid name');
      return false;
    } else if (emailController.text.isEmpty) {
      showErrorToast('email address cant be empty');
      return false;
    } else if (!isValidEmail(emailController.text)) {
      showErrorToast('Enter a valid email address');
      return false;
    } else if (mobileController.text.isEmpty) {
      showErrorToast('Mobile number cant be empty');
      return false;
    } else if (mobileController.text.length < 10) {
      showErrorToast('Enter valid phone number');
      return false;
    } else if (passwordController.text.isEmpty) {
      showErrorToast('Password can\'t be empty');
      return false;
    } else if (passwordController.text.length < 8) {
      showErrorToast('Password mut be of length >=8');
      return false;
    } else if (confirmPasswordcontroller.text.isEmpty) {
      showErrorToast('Confirm your entered password');
      return false;
    } else if (passwordController.text != confirmPasswordcontroller.text) {
      showErrorToast('Password and confirm password doesn\'t match');
      return false;
    } else {
      return true;
    }
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }
}

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.buttonColor,
      required this.textColor,
      required this.isLoading,
      required this.loadingColor,
      this.icon});

  final String label;
  final void Function() onTap;
  final Color buttonColor;
  final Color textColor;
  final Icon? icon;
  final bool isLoading;
  final Color loadingColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoading) ...[
              if (icon != null) ...[
                icon!,
                const SizedBox(
                  width: 10,
                ),
              ],
              Text(
                label,
                style: AppTextStyles.appTextStyle(
                    fontColor: textColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ],
            if (isLoading) ...[
              CircularProgressIndicator(
                color: loadingColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}

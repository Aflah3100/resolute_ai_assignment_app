import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/otp_verification_screen.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class PhoneNumberVerificationScreen extends StatelessWidget {
  static const routeName = RouteConstants.phoneNumberVerificationScreen;
  PhoneNumberVerificationScreen({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Phone-animation
              Center(
                  child: Lottie.asset(Assets.phoneAnimation,
                      height: height * 0.25, repeat: false)),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter Phone Number',
                  style: AppTextStyles.appTextStyle(
                      fontColor: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Please enter phone number to send OTP.',
                  style: AppTextStyles.appTextStyle(
                      fontColor: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1.0),
                      ),
                      hintText: 'Phone number',
                      hintStyle:
                          AppTextStyles.appTextStyle(fontColor: Colors.grey),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.phone,
                        color: AppColors.darkBlueColor,
                        size: 20,
                      )),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              AuthenticationButton(
                label: 'Send OTP',
                onTap: () {
                  if (phoneController.text.isEmpty) {
                    showErrorToast('Please enter a phone number');
                  } else if (phoneController.text.length < 10) {
                    showErrorToast('Enter a valid phone number');
                  } else {
                    //Authentication
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${phoneController.text}',
                      verificationCompleted:
                          (PhoneAuthCredential userCredential) async {
                        await FirebaseAuth.instance
                            .signInWithCredential(userCredential);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserProfileScreen(
                                    fullName: 'OTP AUTO CHECK',
                                    emailAddress: 'otpautocheck@gmail.com',
                                    mobileNumber: '9090909090')));
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        showErrorToast('Verification Failed: ${e.message}');
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => OtpVerificationScreen(
                                    phoneNumber: phoneController.text,
                                    verificationId: verificationId)));
                      },
                      codeAutoRetrievalTimeout: (verificationId) {
                        Fluttertoast.showToast(
                            msg:
                                'Auto-retrieval timed out. Please enter the OTP manually. ',
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            gravity: ToastGravity.CENTER);
                      },
                    );
                  }
                },
                buttonColor: AppColors.darkBlueColor,
                textColor: Colors.white,
                isLoading: false,
                loadingColor: Colors.white,
              )
            ],
          ),
        ),
      )),
    );
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}

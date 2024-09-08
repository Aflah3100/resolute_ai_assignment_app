import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const routeName = RouteConstants.otpVerificationScreen;
  const OtpVerificationScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  final String phoneNumber;
  final String verificationId;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isVerfying = false;
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
              Lottie.asset(Assets.otpVerificationAnimation,
                  height: height * 0.4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Enter OTP',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A 4 digit OTP code has been sent to',
                      style: AppTextStyles.appTextStyle(
                          fontColor: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.phoneNumber,
                      style: AppTextStyles.appTextStyle(
                          fontColor: AppColors.lightBlueColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              // OTP-textfield
              (!isVerfying)
                  ? OtpTextField(
                      numberOfFields: 4,
                      showFieldAsBox: true,
                      fieldWidth: 50,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(9),
                      focusedBorderColor: AppColors.darkBlueColor,
                      textStyle: AppTextStyles.appTextStyle(
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      onSubmit: (value) async {
                        try {
                          final userCredential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: value);

                          await FirebaseAuth.instance
                              .signInWithCredential(userCredential);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return UserProfileScreen(
                                fullName: 'OTP LOGIN CHECK',
                                emailAddress: 'otplogian@gmail.com',
                                mobileNumber: '8080808080');
                          }));
                        } catch (e) {
                          Fluttertoast.showToast(msg: 'Verification failed $e');
                        }
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verifying OTP',
                          style: AppTextStyles.appTextStyle(
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const CircularProgressIndicator(
                          color: AppColors.darkBlueColor,
                        )
                      ],
                    ),
              const SizedBox(
                height: 40,
              ),
              if (!isVerfying)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t recieve the OTP? ',
                      style: AppTextStyles.appTextStyle(
                          fontSize: 17,
                          fontColor: Colors.grey[800]!,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        //Resend-OTP
                      },
                      child: Text(
                        'Send Again',
                        style: AppTextStyles.appTextStyle(
                            fontSize: 17,
                            fontColor: AppColors.darkBlueColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      )),
    );
  }
}

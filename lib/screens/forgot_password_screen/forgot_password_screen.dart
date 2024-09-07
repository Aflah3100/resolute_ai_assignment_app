import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = RouteConstants.forgotPasswordScreen;
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

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
                  child: Text(
                    'Don\'t worry it happens. Please enter the email id associated with your account.',
                    style: AppTextStyles.appTextStyle(
                        fontColor: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
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
                    onTap: () {},
                    buttonColor: AppColors.darkBlueColor,
                    textColor: Colors.white)
              ],
            ),
          ),
        ),
      )),
    );
  }
}

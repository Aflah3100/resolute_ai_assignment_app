import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class NewUserRegisterScreen extends StatelessWidget {
  static const routeName = RouteConstants.NewUserRegisterScreen;
  const NewUserRegisterScreen(
      {super.key, required this.registeredMobileNumber});

  final String registeredMobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(Assets.registerUserAnimation, repeat: false),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New to the App',
                      style: AppTextStyles.appTextStyle(
                          fontColor: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please fill the below details to get started',
                      style: AppTextStyles.appTextStyle(
                          fontColor: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    //Text-field-container
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          //name-text-field
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300]!, width: 1.0),
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
                          //email-textfield
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300]!, width: 1.0),
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
                          //password-textfield
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300]!, width: 1.0),
                                ),
                                hintText: 'Password',
                                hintStyle: AppTextStyles.appTextStyle(
                                    fontColor: Colors.grey),
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300]!, width: 1.0),
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
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthenticationButton(
                              label: 'Register & Continue',
                              onTap: () {},
                              buttonColor: AppColors.darkBlueColor,
                              textColor: Colors.white)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resolute_ai_assignment_app/providers/auth_scren_provider.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:resolute_ai_assignment_app/screens/otp_auth_screen/phone_number_verification_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = RouteConstants.authenticationScreen;
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final authScreenProvider =
        Provider.of<AuthScrenProvider>(context, listen: true);
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
                //Heading-text
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    (!authScreenProvider.isLoginMode()) ? 'Sign up' : 'Login',
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
                      ],

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

                      //mobileno-textfield
                      if (!authScreenProvider.isLoginMode()) ...[
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300]!, width: 1.0),
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
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: (authScreenProvider.isPasswordVisible())
                            ? false
                            : true,
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
                                onPressed: () {
                                  authScreenProvider.setIsPasswordVisible(
                                      !authScreenProvider.isPasswordVisible());
                                },
                                icon: Icon(
                                  (authScreenProvider.isPasswordVisible())
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ))),
                      ),
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
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: AppTextStyles.appTextStyle(
                                    fontSize: 17,
                                    fontColor: AppColors.darkBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      //confirm-password-textfield
                      if (!authScreenProvider.isLoginMode()) ...[
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
                  AuthenticationButton(
                    label: 'Continue',
                    onTap: () {},
                    buttonColor: AppColors.lightBlueColor,
                    textColor: Colors.white,
                  ),
                if (authScreenProvider.isLoginMode())
                  //Login Button
                  AuthenticationButton(
                    label: 'Login',
                    onTap: () {},
                    buttonColor: AppColors.lightBlueColor,
                    textColor: Colors.white,
                  ),
                const SizedBox(
                  height: 20,
                ),

                if (authScreenProvider.isLoginMode()) ...[
                  //Divider-Stack
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Navigator.pushNamed(
                            context, PhoneNumberVerificationScreen.routeName);
                      },
                      buttonColor: Colors.grey[100]!,
                      textColor: Colors.grey[600]!),
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
                        authScreenProvider
                            .setLogin(!(authScreenProvider.isLoginMode()));
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
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.buttonColor,
      required this.textColor,
      this.icon});

  final String label;
  final void Function() onTap;
  final Color buttonColor;
  final Color textColor;
  final Icon? icon;

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
        ),
      ),
    );
  }
}

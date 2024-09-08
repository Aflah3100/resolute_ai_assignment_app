import 'package:flutter/material.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class UserProfileScreen extends StatelessWidget {
  final String fullName;
  final String emailAddress;
  final String mobileNumber;

  // Constructor to pass user details
  UserProfileScreen({
    required this.fullName,
    required this.emailAddress,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info',
          style: AppTextStyles.appTextStyle(
              fontColor: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.lightBlueColor,
              child: Text(
                getInitials(
                  fullName,
                ),
                style: AppTextStyles.appTextStyle(
                    fontColor: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            // Full Name
            Text(
              fullName,
              style: AppTextStyles.appTextStyle(
                  fontColor: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Email Address
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  emailAddress,
                  style: AppTextStyles.appTextStyle(
                      fontColor: Colors.grey[700]!,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Mobile Number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  mobileNumber,
                  style: AppTextStyles.appTextStyle(
                      fontColor: Colors.grey[700]!,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),


            const Spacer(),
          ],
        ),
      ),
    );
  }

  String getInitials(String fullName) {
    if (fullName.isEmpty) return '';

    String initials = fullName.substring(0, 2);

    return initials.toUpperCase();
  }
}

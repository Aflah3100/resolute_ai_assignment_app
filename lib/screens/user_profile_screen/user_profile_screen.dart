import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/widgets/google_map_widget.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class UserProfileScreen extends StatefulWidget {
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
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  LatLng? _tappedPoint;
  LatLng? _laterLatLng;

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      _tappedPoint = tappedPoint;
      _laterLatLng = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info',
          style: AppTextStyles.appTextStyle(
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            //Google-Map-Widget
            SizedBox(
              height: 300,
              child: GoogleMapWidget(
                onMapTap: (mTappedPoint) => _handleTap(mTappedPoint),
                initialLatLng: _tappedPoint,
                laterLatLng: _laterLatLng,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.lightBlueColor,
              child: Text(
                getInitials(
                  widget.fullName,
                ),
                style: AppTextStyles.appTextStyle(
                    fontColor: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            // Full Name
            Center(
              child: Text(
                widget.fullName,
                style: AppTextStyles.appTextStyle(
                    fontColor: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Email Address
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  widget.emailAddress,
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
                  widget.mobileNumber,
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

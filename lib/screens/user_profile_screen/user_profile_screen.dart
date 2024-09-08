// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resolute_ai_assignment_app/router/route_constants.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/widgets/google_map_widget.dart';
import 'package:resolute_ai_assignment_app/services/shared_prefs.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = RouteConstants.userProfileScreen;
  // Constructor to pass user details
  const UserProfileScreen({super.key});

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

            //User-info-column
            FutureBuilder(
              future: SharedPrefs.instance.getSavedUserModel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.darkBlueColor,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.lightBlueColor,
                        child: Text(
                          getInitials(
                            snapshot.data!.fullName,
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
                          snapshot.data!.fullName,
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
                            snapshot.data!.emailId,
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
                            snapshot.data!.mobileNo,
                            style: AppTextStyles.appTextStyle(
                                fontColor: Colors.grey[700]!,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      //Signout-button
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.redAccent)),
                          onPressed: () async {
                            await SharedPrefs.instance.deleteSavedUser();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AuthenticationScreen.routeName,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Sign Out',
                            style: AppTextStyles.appTextStyle(
                                fontColor: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
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

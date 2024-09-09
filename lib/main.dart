import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolute_ai_assignment_app/providers/auth_scren_provider.dart';
import 'package:resolute_ai_assignment_app/router/generate_route.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/screens/user_profile_screen/user_profile_screen.dart';
import 'package:resolute_ai_assignment_app/services/shared_prefs.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize-firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => AuthScrenProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Resolute AI Assignment',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.darkBlueColor),
            useMaterial3: true,
          ),
          onGenerateRoute: generateRoute,
          home: FutureBuilder(
            future: SharedPrefs.instance.getSavedUserModel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                //User-logged-in
                return const UserProfileScreen();
              } else {
                return AuthenticationScreen();
              }
            },
          )),
    );
  }
}

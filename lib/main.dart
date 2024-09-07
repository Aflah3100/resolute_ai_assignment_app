import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolute_ai_assignment_app/providers/auth_scren_provider.dart';
import 'package:resolute_ai_assignment_app/router/generate_route.dart';
import 'package:resolute_ai_assignment_app/screens/auth_screen/authentication_screen.dart';
import 'package:resolute_ai_assignment_app/utils/assets.dart';

void main() {
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
        title: 'Resolute AI Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkBlueColor),
          useMaterial3: true,
        ),
        onGenerateRoute: generateRoute,
        home: const AuthenticationScreen(),
      ),
    );
  }
}

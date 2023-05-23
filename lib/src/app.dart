import 'package:green_style/src/view/screens/comparison_screen.dart';
import 'package:green_style/src/view/screens/forgot_password.dart';
import 'package:green_style/src/view/screens/reset_password.dart';
import 'package:green_style/src/view/screens/questionnaire.dart';
import 'package:green_style/src/view/screens/registration.dart';
import 'package:green_style/src/view/screens/pre_home.dart';
import 'package:green_style/src/view/screens/welcome.dart';
import 'package:green_style/src/view/screens/login.dart';
import 'package:green_style/src/view/screens/home.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: greenStyleTheme,
      home: const WelcomeScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginScreen(),
        '/resetPassword': (context) => ResetPasswordPage(),
        '/register': (context) => RegistrationScreen(),
        '/quiz': (context) => const QuestionnaireScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/prehome': (context) => const PreHome(),
        '/compare': (context) => const ComparisonScreen(),
        //'/account': (context) => AccountScreen(),
      },
    );
  }
}

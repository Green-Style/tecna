import 'package:green_style/src/view/screens/reset_password.dart';
import 'package:green_style/src/view/screens/welcome.dart';
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
      // TODO: Criar rotas após terminar telas
      routes: {
      //   '/': (context) => HomeScreen(),
      //   '/login': (context) => LoginScreen(),
        '/resetPassword': (context) => ResetPasswordPage(),
      //   '/register': (context) => RegisterPage(),
      //   '/quiz': (context) => QuizScreen(),
      //   '/compare': (context) => ComparisonScreen(),
      //   '/account': (context) => AccountScreen(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:green_style/models/general_info.dart';
import 'package:green_style/screens/welcome.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Style',
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(generalInfo: [ // TODO: Remove test objects and receive from API
        GeneralInfo(id: 'asd', description: 'sdasdasdasd', categoryId: 0),
        GeneralInfo(id: 'aad', description: 'ajsdbhjykhsdbfuyasdbuyifasdbuyfasdibvdfas', categoryId: 0),
        GeneralInfo(id: 'add', description: 'Henlo, are u myh frende???', categoryId: 0),
        GeneralInfo(id: 'ads', description: 'Just die, Criminal Scum?\n Oh, it was for a youtube video? Ok, I\'ll let you pass this time...', categoryId: 0)
      ]),
    );
  }
}
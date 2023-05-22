import 'package:flutter/material.dart';
import 'package:green_style/src/controller/home_controller.dart';

class PreHome extends StatefulWidget {
  const PreHome({super.key});

  @override
  State<PreHome> createState() => _PreHomeState();
}

class _PreHomeState extends State<PreHome> {
  final homeCtrl = HomeController();

  void passToQuizOrHome(bool hasAnswered) {
    if (!hasAnswered) {
      Navigator.of(context).pushReplacementNamed('/quiz');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void checkIfUserHasAnswered() async {
    passToQuizOrHome(await homeCtrl.answeredAtLeastOneForm());
  }

  @override
  void initState() {
    checkIfUserHasAnswered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white
        ),
      ),
    );
  }
}
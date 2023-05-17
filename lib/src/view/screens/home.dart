import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/view/info_chart.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: InfoChart(),
          bottomNavigationBar: GreenStyleBottomNavigationBar(),
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/view/comparison_chart.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ComparisonChart(),
          bottomNavigationBar: const GreenStyleBottomNavigationBar(selectedIndex: 1),
        ),
    );
  }
}
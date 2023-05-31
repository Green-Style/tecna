import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/view/comparison_chart.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(FontAwesomeIcons.chartSimple),
          title: const Text('Comparação de Médias'),
          centerTitle: true,
          backgroundColor: darkBackgroundColor,
          elevation: 0,
        ),
        body: ComparisonChart(),
        bottomNavigationBar:
            const GreenStyleBottomNavigationBar(selectedIndex: 1),
      ),
    );
  }
}

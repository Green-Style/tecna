import 'package:green_style/src/view/general_info_list.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GeneralInfoList(),
    );
  }
}

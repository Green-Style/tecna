import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/settings_controller.dart';
import 'package:green_style/src/view/settings_user_info.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final settingsCtrl = SettingsController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SettingsUserInfo(),
        bottomNavigationBar: GreenStyleBottomNavigationBar(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Text
const String appName = 'Green Style';
const String apiUrl = 'greenstyle.brazilsouth.cloudapp.azure.com:1337';
const String userTokenKey = 'greenStyleUserToken';

// Colors
const Color lightBackgroundColor = Colors.white;
const Color darkBackgroundColor = Color.fromARGB(255, 5, 28, 62);
const Color buttonBackgroundColor = Color.fromARGB(255, 51, 163, 96);
const Color activebuttonBackgroundColor = Color.fromARGB(255, 34, 108, 64);

final greenStyleTheme = ThemeData(
  scaffoldBackgroundColor: lightBackgroundColor,
  primarySwatch: Colors.green,
);

// Complexer widgets
class GreenStyleBottomNavigationBar extends StatefulWidget {


  @override
  State<GreenStyleBottomNavigationBar> createState() => _GreenStyleBottomNavigationBarState();
}

class _GreenStyleBottomNavigationBarState extends State<GreenStyleBottomNavigationBar> {
  int _currentIndex = 0;

  @override Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.chartPie),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.clipboardQuestion),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: ''
        ),
      ],
      selectedItemColor: buttonBackgroundColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed(
              '/'
            );
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed(
              '/compare'
            );
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed(
              '/quiz'
            );
            break;
          case 3:
            Navigator.of(context).pushReplacementNamed(
              '/account'
            );
            break;
        }
      },
    );
  }
}
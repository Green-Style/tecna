import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Text
const String appName = 'Green Style';
const String apiUrl = 'greenstyle.brazilsouth.cloudapp.azure.com:1337';
const String userTokenKey = 'greenStyleUserToken';

// Colors
const Color lightBackgroundColor = Colors.white;
const Color borderColor = Colors.black;
const Color darkBackgroundColor = Color.fromARGB(255, 5, 28, 62);
const Color buttonBackgroundColor = Color.fromARGB(255, 51, 163, 96);
const Color activebuttonBackgroundColor = Color.fromARGB(255, 34, 108, 64);
const Color lightFontColor = Colors.white;
const Color darkFontColor = Color.fromARGB(255, 2, 14, 32);
const Color foodCategoryColor = Color.fromARGB(255, 145, 5, 54);
const Color electricityCategoryColor = Color.fromARGB(255, 8, 144, 198);
const Color purchaseCategoryColor = Color.fromARGB(255, 103, 245, 21);
const Color transportationCategoryColor = Color.fromARGB(255, 63, 2, 155);
const Color initialEmissionColor = Color.fromARGB(255, 8, 144, 198);
const Color actualEmissionColor = Color.fromARGB(255, 103, 245, 21);
const Color globalEmissionColor = Color.fromARGB(255, 63, 2, 155);

final greenStyleTheme = ThemeData(
  scaffoldBackgroundColor: lightBackgroundColor,
  primarySwatch: Colors.green,
);

// Complexer widgets
class GreenStyleBottomNavigationBar extends StatefulWidget {
  const GreenStyleBottomNavigationBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<GreenStyleBottomNavigationBar> createState() => _GreenStyleBottomNavigationBarState();
}

class _GreenStyleBottomNavigationBarState extends State<GreenStyleBottomNavigationBar> {
  @override Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
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
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(
              '/home'
            );
            break;
          case 1:
            Navigator.of(context).pushNamed(
              '/compare'
            );
            break;
          case 2:
            Navigator.of(context).pushNamed(
              '/quiz'
            );
            break;
          case 3:
            Navigator.of(context).pushNamed(
              '/account'
            );
            break;
        }
      },
    );
  }
}
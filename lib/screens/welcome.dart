import 'package:green_style/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import '../models/general_info.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.generalInfo});
  final List<GeneralInfo> generalInfo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: createWelcomePages(generalInfo),
        showSkipButton: true,
        skip: const Text('Pular'), // TODO: Add theme style
        next: const Icon(Icons.arrow_forward_rounded),
        dotsDecorator: DotsDecorator(
          activeColor: activeColor,
          activeSize: const Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          )
        ),
        // TODO: Make 'done'  a button
        done: const Text( // TODO: Add theme style
          'Vamos lá',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onDone: () {
          // TODO: Remove comments when login page is complete
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => LoginPage(),
          //   )
          // );
        },
      ),
    );
  }

  List<PageViewModel> createWelcomePages(List<GeneralInfo> generalInfo) {
    return generalInfo.map((element) => PageViewModel( // TODO: Add theme style
      title: '',
      body: element.description,
      image: buildImage(element.categoryId),
      decoration: const PageDecoration(
        bodyAlignment: Alignment.center,
        bodyTextStyle: TextStyle(fontSize: 25),
        imagePadding: EdgeInsets.all(40)
      )
    )).toList();
  }

  Widget buildImage(int categoryId) {
    return Center( // TODO: Create proper widget selection according to category
      child: Image.asset(
        'assets/icons/green_style_white_small.png',
        width: 350)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:green_style/src/model/general_info.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:green_style/src/controller/welcome_controller.dart';

class GeneralInfoList extends StatelessWidget{
  GeneralInfoList({super.key});
  final welcomeCtrl = WelcomeController();

  Future<List<GeneralInfo>> _getInfo() async {
    final data = await welcomeCtrl.getInfo();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInfo(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return IntroductionScreen(
                pages: createWelcomePages(snapshot.data!),
                showSkipButton: true,
                skip: const Text('Pular'), // TODO: Add theme style
                next: const Icon(Icons.arrow_forward_rounded),
                dotsDecorator: DotsDecorator(
                    activeColor: Theme.of(context).primaryColor,
                    activeSize: const Size(22, 10),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                // TODO: Make 'done'  a button
                done: const Text(
                  // TODO: Add theme style
                  'Vamos lá',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onDone: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              );
            }
        }
      },
    );
  }

  List<PageViewModel> createWelcomePages(List<GeneralInfo> generalInfo) {
    return generalInfo
        .map((element) => PageViewModel(
            // TODO: Add theme style
            title: '',
            body: element.description,
            image: buildImage(element.categoryId),
            decoration: const PageDecoration(
                bodyAlignment: Alignment.center,
                bodyTextStyle: TextStyle(fontSize: 25),
                imagePadding: EdgeInsets.all(40))))
        .toList();
  }

  Widget buildImage(int categoryId) {
    String assetFile = '';

    switch (categoryId) {
      case 1: // TODO: Change image according to category
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
      case 2: // TODO: Change image according to category
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
      case 3: // TODO: Change image according to category
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
      case 4: // TODO: Change image according to category
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
      case 5: // TODO: Change image according to category
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
      default:
        assetFile = 'assets/icons/green_style_white_small.png';
        break;
    }

    return Center(
        // TODO: Create proper widget selection according to category
        child: Image.asset(assetFile, width: 350));
  }
}

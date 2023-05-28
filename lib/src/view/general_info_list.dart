import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/general_info.dart';
import 'package:green_style/src/model/welcome_data.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:green_style/src/controller/welcome_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GeneralInfoList extends StatelessWidget {
  GeneralInfoList({super.key});
  final welcomeCtrl = WelcomeController();

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<WelcomeData> _getInfo() async {
    WelcomeData data = WelcomeData(
        info: await welcomeCtrl.getInfo(), token: await getUserToken());
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
                pages: createWelcomePages(snapshot.data!.info),
                showSkipButton: true,
                skip: const Text(
                  'Pular',
                  style: TextStyle(
                    color: Color.fromRGBO(47, 175, 239, 1),
                  ),
                ), // TODO: Add theme style
                next: const Icon(Icons.arrow_forward_rounded),
                dotsDecorator: DotsDecorator(
                    activeColor: const Color.fromRGBO(47, 175, 239, 1),
                    activeSize: const Size(22, 10),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                // TODO: Make 'done'  a button
                done: const Text(
                  // TODO: Add theme style
                  'Vamos lá',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(47, 175, 239, 1),
                  ),
                ),
                onDone: () {
                  snapshot.data!.token != null
                      ? Navigator.of(context).pushReplacementNamed('/prehome')
                      : Navigator.of(context).pushReplacementNamed('/login');
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
            titleWidget: Image.asset(
              'assets/icons/green_style_white_small.png',
              width: 200,
              alignment: Alignment.topCenter,
            ),
            // body: element.description,
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildImage(element.categoryId),
                const SizedBox(height: 20),
                Text(
                  element.description,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
            decoration: const PageDecoration(
                imageAlignment: Alignment.centerLeft,
                bodyAlignment: Alignment.bottomCenter,
                bodyTextStyle: TextStyle(fontSize: 10),
                imagePadding: EdgeInsets.all(0))))
        .toList();
  }

  Widget buildImage(int categoryId) {
    Image imageAsset =
        Image.asset('assets/icons/carbon_footprint.png', width: 140);

    switch (categoryId) {
      case 1:
        imageAsset = Image.asset('assets/icons/car_icon.png', width: 250);
        break;
      case 2:
        imageAsset = Image.asset('assets/icons/food_icon.png', width: 130);
        break;
      case 3:
        imageAsset = Image.asset('assets/icons/light_icon.png', width: 150);
        break;
      default:
        break;
    }
    return Center(child: imageAsset);
  }
}

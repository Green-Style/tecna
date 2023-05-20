import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/controller/question_controller.dart';

class QuestionList extends StatelessWidget {
  final welcomeCtrl = QuestionController();

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<List<Question>> _getInfo() async {
    final data = await welcomeCtrl.getForm(await getUserToken());

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
              return Center(
                child: Text('Tela de questionário'),
              );
            }
        }
      },
    );
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

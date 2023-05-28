import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/controller/question_controller.dart';

class QuestionList extends StatefulWidget {
  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final questionCtrl = QuestionController();
  List<Map> answers = [];
  Future<List<Question>>? _questionsFuture;
  int? _groupValue;
  int _index = 0;

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<List<Question>> _getForm() async {
    final data = await questionCtrl.getForm(await getUserToken());

    return data;
  }

  Future<bool> _saveForm() async {
    final data = await questionCtrl.saveForm(await getUserToken(), answers);

    return data;
  }

  @override
  initState() {
    _questionsFuture = _getForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questionsFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: darkBackgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Center(
                            child: buildImage(snapshot.data![_index].category.id),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              snapshot.data![_index].description,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: DecoratedBox( // Legendas
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                          border: Border.all(
                            style: BorderStyle.none
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data![_index].options.map(
                                  (e) => Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SizedBox(
                                        width: 300,
                                        child: RadioListTile(
                                          value: e.id,
                                          title: Text(
                                            e.description
                                          ),
                                          groupValue: _groupValue,
                                          onChanged: (val) {
                                            setState(() {
                                              _groupValue = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ).toList()
                              ),
                            ),
                            ElevatedButton(
                              child: Text(
                                _index == (snapshot.data!.length - 1) ? 'Terminar' : 'Avançar'
                              ),
                              onPressed: () {
                                if (_groupValue != null) {
                                  if (_index == (snapshot.data!.length - 1)) {
                                    answers.add({'question': snapshot.data![_index].id, 'option': _groupValue});
                                    _saveForm().then((value) {
                                      Navigator.of(context).pushReplacementNamed('/home');
                                    }, onError: (error) {
                                      return Text(error);
                                    });
                                  } else {
                                    setState(() {
                                      answers.add({'question': snapshot.data![_index].id, 'option': _groupValue});
                                      _groupValue = null;
                                      _index++;
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
        child: Image.asset(assetFile, width: 150));
  }
}

import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';
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
              return Scaffold(
                bottomNavigationBar: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _groupValue != null
                            ? Colors.green
                            : const Color.fromARGB(10, 158, 158, 158),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    child: Text(_index == (snapshot.data!.length - 1)
                        ? 'Terminar'
                        : 'Avançar'),
                    onPressed: () {
                      if (_groupValue != null) {
                        if (_index == (snapshot.data!.length - 1)) {
                          answers.add({
                            'question': snapshot.data![_index].id,
                            'option': _groupValue
                          });
                          _saveForm().then((value) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }, onError: (error) {
                            return Text(error);
                          });
                        } else {
                          setState(() {
                            answers.add({
                              'question': snapshot.data![_index].id,
                              'option': _groupValue
                            });
                            _groupValue = null;
                            _index++;
                          });
                        }
                      }
                    },
                  ),
                ),
                body: DecoratedBox(
                  decoration: const BoxDecoration(
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
                              child: buildImage(
                                  snapshot.data![_index].category.id),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: DecoratedBox(
                          // Legendas
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)),
                              border: Border.all(style: BorderStyle.none)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(left: 15),
                                child: Center(
                                  child: Text(
                                    snapshot.data![_index].description,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: snapshot.data![_index].options
                                      .map((e) => SizedBox(
                                            width: 500,
                                            child: RadioListTile(
                                              value: e.id,
                                              title: Text(e.description,
                                                  style: _groupValue == e.id
                                                      ? const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w900)
                                                      : const TextStyle()),
                                              groupValue: _groupValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  _groupValue = val;
                                                });
                                              },
                                            ),
                                          ))
                                      .toList()),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
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

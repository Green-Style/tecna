import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/general_info.dart';

class WelcomeController {
  Future<List<GeneralInfo>> getInfo() async {
    // TODO: Uncomment
    // var url = Uri.https(apiUrl, '/getInfo');
    // final response = await http.get(url);
    // List<dynamic> data = jsonDecode(response.body);
    List<GeneralInfo> info = [];

    // TODO: Remove after tests
    // Remove - Start
    String testData = '''
    [{
      "id": "1",
      "description": "70.8% da superfície da Terra é coberta por água, sendo que 2,2% é água doce. Para consumo, o que temos disponível é apenas 0.3%",
      "categoryId": 1
    },
    {
      "id": "2",
      "description": "A produção de lixo no mundo deve subir de 1,3 bilhão de toneladas para 2,2 bilhões de toneladas até 2025",
      "categoryId": 2
    },
    {
      "id": "3",
      "description": "Ar poluído mata mais de 7 milhões de pessoas por ano",
      "categoryId": 3
    },
    {
      "id": "4",
      "description": "Para produzir 1kg de carne de boi são necessários 17.100 litros de água",
      "categoryId": 1
    }]
    ''';
    List<dynamic> data = jsonDecode(testData);
    // Remove - End

    for (var i = 0; i < data.length; i++) {
      info.add(GeneralInfo.fromJson(data[i]));
    }

    // TODO: Remove after tests
    // Remove - Start
    return Future.delayed(const Duration(seconds: 10), () {
      return info;
    });
    // Remove - End

    //return info;
  }
}

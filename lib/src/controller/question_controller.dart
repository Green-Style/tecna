import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';

class QuestionController {
  Future<List<Question>> getForm(String? userToken) async {
    Map<String,String> tokenHeaders = {
      'Authorization': 'Bearer $userToken'
    };

    var url = Uri.https(apiUrl, '/api/random-form');
    final response = await http.get(url, headers: tokenHeaders);
    List<dynamic> data = jsonDecode(response.body);
    List<Question> questions = [];

    for (var i = 0; i < data.length; i++) {
      questions.add(Question.fromJson(data[i]));
    }

    return questions;
  }
}

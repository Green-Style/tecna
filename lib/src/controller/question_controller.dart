import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';

class QuestionController {
  Future<List<Question>> getForm(String? userToken) async {
    Map<String,String> tokenHeaders = {
      'Authorization': 'Bearer $userToken'
    };

    var url = Uri.http(apiUrl, '/api/random-form');
    final response = await http.get(url, headers: tokenHeaders);
    List<dynamic> data = jsonDecode(response.body);
    List<Question> questions = [];

    for (var i = 0; i < data.length; i++) {
      questions.add(Question.fromJson(data[i]));
    }

    return questions;
  }

  Future<bool> saveForm(String? userToken, List<Map> answers) async {
    Map<String,String> tokenHeaders = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json'
    };

    String answerJson = jsonEncode(answers);

    var url = Uri.http(apiUrl, '/api/save-form');
    final response = await http.post(url, headers: tokenHeaders, body: answerJson);
    dynamic data = jsonDecode(response.body);
    
    if (data.containsKey('id')) return true;

    return false;
  }
}

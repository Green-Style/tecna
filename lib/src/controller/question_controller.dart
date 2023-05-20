import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/question.dart';

class QuestionController {
  Future<List<Question>> getForm(String? userToken) async {
    // TODO: Change later
  String bearerToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjgzMDI1MjIyLCJleHAiOjE2ODU2MTcyMjJ9.puruzhJDJFPaWW_JXpKNa9AePXfZPHgu2ePkL0fsQa4';
    Map<String,String> tokenHeaders = {
      'Authorization': 'Bearer $bearerToken'
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
}

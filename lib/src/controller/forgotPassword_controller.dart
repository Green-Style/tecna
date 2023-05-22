import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';

class ForgotPasswordController {
  Future<void> exec(String email) async {
    var url = Uri.http(apiUrl, '/api/auth/forgot-password');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': email
        }));
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode != 200) {
      throw Exception('Falha ao solicitar recuperação de senha.');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';

class RegisterController {
  Future<void> signUp(String email, String password, String username) async {
    var url = Uri.http(apiUrl, '/api/auth/local/register');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'email': email
        }));
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode != 200) {
      throw Exception('Falha ao realizar cadastro');
    }
  }
}

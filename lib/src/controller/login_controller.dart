import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/view/screens/login.dart';

class LoginController {
  Future<void> signIn(String email, String password) async {
    var url = Uri.http(apiUrl, '/api/auth/local');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'identifier': email, 'password': password}));
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode != 200) {
      throw Exception('Erro no login');
    }
  }
}

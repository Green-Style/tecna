import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';

class LoginController {
  Future<void> signIn(String email, String password) async {
    var url = Uri.http(apiUrl, '/api/auth/local');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'identifier': email, 'password': password}));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      await _setToken(data['jwt']);
      return;
    } 
    throw Exception('Erro ao realizar login.');
  }
  
  Future<void> _setToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: userTokenKey, value: token);
  }
}

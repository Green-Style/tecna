import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/settings_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsController {
  Future<SettingsData> getUserInfoSettings() async {
    const storage = FlutterSecureStorage();

    Map<String, String> infoHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${await storage.read(key: userTokenKey)}'
    };
    var url = Uri.http(apiUrl, '/api/user-info');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);

    return SettingsData(userEmail: json['email'], userName: json['username']);
  }

  Future<void> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    const storage = FlutterSecureStorage();

    Map<String, String> tokenHeaders = {
      'Authorization': 'Bearer ${await storage.read(key: userTokenKey)}',
      'Content-Type': 'application/json'
    };
    var url = Uri.http(apiUrl, '/api/auth/change-password');
    final response = await http.post(url,
        headers: tokenHeaders,
        body: jsonEncode(<String, String>{
          "currentPassword": currentPassword,
          "password": newPassword,
          "passwordConfirmation": newPassword
        }));
    if (response.statusCode != 200) {
      throw Exception('Falha ao realizar troca de senha');
    }
  }

  Future<void> logoutUser() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}

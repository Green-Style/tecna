import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/general_info.dart';

class WelcomeController {
  Future<List<GeneralInfo>> getInfo() async {
    var url = Uri.http(apiUrl, '/api/random-eco-infos');
    final response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body);
    List<GeneralInfo> info = [];

    for (var i = 0; i < data.length; i++) {
      info.add(GeneralInfo.fromJson(data[i]));
    }

    return info;
  }
}

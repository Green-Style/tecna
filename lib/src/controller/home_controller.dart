import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:green_style/src/model/comparison.dart';
import 'package:green_style/src/view/comparison_chart.dart';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/home_data.dart';
import 'package:green_style/src/model/user_info_chart_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController {
  Future<HomeData> getUserInfoChartData(String? userToken) async {
    Map<String, String> infoHeaders = {'Authorization': 'Bearer $userToken'};
    var url = Uri.http(apiUrl, '/api/report/my-co-two');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);
    List<dynamic> data = json['qtyCo2perCategory'];
    List<UserInfoChartData> sections = [];

    for (var i = 0; i < data.length; i++) {
      sections.add(UserInfoChartData.fromJson(data[i]));
    }

    return HomeData(
        userChartData: sections
          ..sort((a, b) => b.percentage.compareTo(a.percentage)),
        co2: double.parse(json['qtyCo2'].toString()),
        suggestion: json['suggestion']);
  }

  Future<bool> answeredAtLeastOneForm() async {
    const storage = FlutterSecureStorage();

    Map<String, String> infoHeaders = {
      'Authorization': 'Bearer ${await storage.read(key: userTokenKey)}'
    };
    var url = Uri.http(apiUrl, '/api/user-info');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);

    return json['answeredLeastOneForm'];
  }

  Future<Comparison> getComparisonChartData(String? userToken) async {
    Map<String, String> infoHeaders = {'Authorization': 'Bearer $userToken'};
    var url = Uri.http(apiUrl, '/api/report/compare-co-two');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);

    List<BarData> dataList;
    List<String> labels;
    String comparison;

    dataList = [
      BarData(actualEmissionColor,
          double.parse(json['lastQtyCo2'].toStringAsFixed(2))),
      BarData(initialEmissionColor,
          double.parse(json['firstQtyCo2'].toStringAsFixed(2))),
      BarData(globalEmissionColor,
          double.parse(json['globalQtyCo2'].toStringAsFixed(2)))
    ];

    labels = ['Atual', 'Inicial', 'Global'];

    
    if (dataList[0].value == dataList[1].value) {
      if (dataList[1].value > dataList[2].value) {
        comparison = initialMoreThanGlobal.replaceAll('{0}', (dataList[1].value-dataList[2].value).toStringAsFixed(2));
      } else {
        comparison = initialLessThanGlobal.replaceAll('{0}', (dataList[2].value-dataList[1].value).toStringAsFixed(2));
      }
    } else {
      if (dataList[0].value > dataList[1].value) {
        comparison = actualMoreThanInitial.replaceAll('{0}', (dataList[0].value-dataList[1].value).toStringAsFixed(2));
      } else {
        comparison = actualLessThanInitial.replaceAll('{0}', (dataList[1].value-dataList[0].value).toStringAsFixed(2));
      } 
    }

    return Comparison(
      dataList: dataList,
      labels: labels,
      comparison: comparison
    );
  }

  Color selectColorByPercentage(double percentage) {
    double parsePercentage = percentage / 100;
    if (parsePercentage > 1) {
      parsePercentage = 1;
    } else if (parsePercentage < 0) {
      parsePercentage = 0;
    }

    int green = 0;
    int red = 0;
    int blue = 0;

    if (parsePercentage >= 0.5) {
      red = 255;
      green = (255.0 * (1 - ((parsePercentage - 0.5) * 2))).toInt();
    } else {
      green = 255;
      red = (255.0 * (parsePercentage * 2)).toInt();
    }

    return Color.fromRGBO(red, green, blue, 1);
  }

  String selectCategoryTitle(int categotyId) {
    switch (categotyId) {
      // TODO: Define colors and categories
      case 1:
        return 'Alimentação';
      case 2:
        return 'Transporte';
      default:
        return 'Cotidiano';
    }
  }
}

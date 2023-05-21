import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_style/src/model/home_data.dart';
import 'package:http/http.dart' as http;
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/general_info.dart';
import 'package:green_style/src/model/user_info_chart_data.dart';

class HomeController {
  Future<HomeData> getUserInfoChartData(String? userToken) async {
    // TODO> Remove later
    String bearerToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjgzMDI1MjIyLCJleHAiOjE2ODU2MTcyMjJ9.puruzhJDJFPaWW_JXpKNa9AePXfZPHgu2ePkL0fsQa4';
    Map<String,String> infoHeaders = {
      'Authorization': 'Bearer $bearerToken'
    };
    var url = Uri.http(apiUrl, '/api/report/my-co-two');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);
    List<dynamic> data = json['qtyCo2perCategory'];
    List<UserInfoChartData> sections = [];

    for (var i = 0; i < data.length; i++) {
      sections.add(UserInfoChartData.fromJson(data[i]));
    }

    return HomeData(
      sections: sections.asMap().map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: selectColorByCategory(data.categoryId),
          value: data.percentage,
          title: '${data.percentage}%',
          titleStyle: const TextStyle(
            color: Colors.white
          ),
          radius: 50,
        );
        return MapEntry(index, value);
      }).values.toList(growable: false),
      userChartData: sections,
      co2: double.parse(json['qtyCo2'].toString()),
      suggestion: json['suggestion']
    );
  }

  Color selectColorByCategory(int categotyId) {
    switch(categotyId) {
      // TODO: Define colors and categories
      case 1: return Colors.blue;
      case 2: return Colors.green;
      default: return Colors.grey;
    }
  }

  String selectCategoryTitle(int categotyId) {
    switch(categotyId) {
      // TODO: Define colors and categories
      case 1: return 'Alimentação';
      case 2: return 'Transporte';
      default: return 'Cotidiano';
    }
  }
}

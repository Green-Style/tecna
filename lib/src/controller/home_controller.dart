import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/model/home_data.dart';
import 'package:green_style/src/model/user_info_chart_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController {
  Future<HomeData> getUserInfoChartData(String? userToken) async {
    Map<String,String> infoHeaders = {
      'Authorization': 'Bearer $userToken'
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

  Future<bool> answeredAtLeastOneForm() async {
    const storage = FlutterSecureStorage();
    
    Map<String,String> infoHeaders = {
      'Authorization': 'Bearer ${await storage.read(key: userTokenKey)}'
    };
    var url = Uri.http(apiUrl, '/api/user-info');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);
    
    return json['answeredLeastOneForm'];
  }

  Future<BarChartData> getComparisonChartData(String? userToken) async {
    Map<String,String> infoHeaders = {
      'Authorization': 'Bearer $userToken'
    };
    var url = Uri.http(apiUrl, '/api/report/compare-co-two');
    final response = await http.get(url, headers: infoHeaders);
    dynamic json = jsonDecode(response.body);

    return BarChartData(
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: json['firstQtyCo2'],
              color: Colors.amber
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: json['lastQtyCo2'],
              color: Colors.blue
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: json['globalQtyCo2'],
              color: Colors.orange
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ],
      barTouchData: BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              String text;

              switch(value.toInt()) {
                case 0:
                  text = 'Inicial';
                  break;
                case 1:
                  text = 'Atual';
                  break;
                case 2:
                  text = 'Global';
                  break;
                default:
                  text = '';
                  break;
              }

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 4,
                child: Text(text),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(show: false),
      alignment: BarChartAlignment.spaceAround,
      maxY: 20,
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

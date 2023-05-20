import 'package:fl_chart/fl_chart.dart';
import 'package:green_style/src/model/user_info_chart_data.dart';

class HomeData {
  String suggestion;
  double co2;
  List<PieChartSectionData> sections;
  List<UserInfoChartData> userChartData;

  HomeData({
    required this.sections,
    required this.userChartData,
    required this.suggestion,
    required this.co2
  });
}
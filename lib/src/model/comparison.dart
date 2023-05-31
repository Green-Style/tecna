import 'package:green_style/src/view/comparison_chart.dart';

class Comparison {
  List<BarData> dataList;
  List<String> labels;
  String comparison;

  Comparison({
    required this.dataList,
    required this.labels,
    required this.comparison,
  });
}
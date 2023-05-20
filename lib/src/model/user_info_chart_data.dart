class UserInfoChartData {
  String categoryName;
  int categoryId;
  double percentage;
  double value;

  UserInfoChartData({
    required this.categoryId,
    required this.percentage,
    required this.value,
    required this.categoryName,
  });

  factory UserInfoChartData.fromJson(Map<String, dynamic> json) {
    return UserInfoChartData(
      categoryName: json['category'],
      categoryId: json['id'],
      percentage: double.parse(json['percentage'].toString()),
      value: double.parse(json['qtyCo2'].toString())
    );
  }
}
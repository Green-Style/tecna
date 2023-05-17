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
      percentage: json['percentage'],
      value: json['qtyCo2']
    );
  }
}
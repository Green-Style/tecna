class GeneralInfo {
  String description;
  int categoryId;

  GeneralInfo({
    required this.description,
    required this.categoryId,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) {
    return GeneralInfo(
      categoryId: json['category_id'],
      description: json['description'],
    );
  }
}

class GeneralInfo {
  String id;
  String description;
  int categoryId;

  GeneralInfo({
    required this.id,
    required this.description,
    this.categoryId = 0,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) {
    return GeneralInfo(
      id: json['id'],
      categoryId: json['categoryId'],
      description: json['description'],
    );
  }
}

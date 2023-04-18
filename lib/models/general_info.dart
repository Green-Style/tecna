class GeneralInfo {
  String id;
  String description;
  int categoryId;

  GeneralInfo({
    required this.id,
    this.categoryId = 0,
    this.description = '',
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) {
    return GeneralInfo(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}

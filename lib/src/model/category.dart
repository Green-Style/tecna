class Category {
  int id;
  String description;

  Category({
    required this.id,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      description: json['Description'],
    );
  }
}

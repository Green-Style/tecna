class Option {
  int id;
  String description;

  Option({
    required this.id,
    required this.description,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['Description'],
    );
  }
}

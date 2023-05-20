import 'package:green_style/src/model/option.dart';

class Question {
  int id;
  String description;
  List<Option> options;

  Question({
    required this.id,
    required this.description,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Option> options = [];
    for (var i = 0; i < json['options'].length; i++) {
      options.add(Option.fromJson(json['options'][i]));
    }

    return Question(
      id: json['id'],
      description: json['Text'],
      options: options,
    );
  }
}

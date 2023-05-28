import 'package:green_style/src/view/question_list.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: QuestionList(),
      ),
    );
  }
}

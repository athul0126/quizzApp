import 'package:flutter/material.dart';
import 'package:quizapp/Constants/sized_boxes.dart';
import 'package:quizapp/Widgets/elevatedButton.dart';

class QuizRules extends StatelessWidget {
  final String level;
  QuizRules({super.key, required this.level});
  final List quizRules = [
    "Each question will have a time limit of 30 seconds. Users must select their answer within this time frame, or the quiz will automatically proceed to the next question",
    "Users will earn 1 mark for each correct answer. At the end of the quiz, the total score will be calculated based on the number of correct answers out of the total 10 questions",
    "All questions in the quiz will be presented in a multiple-choice format. Each question will have at least three options for users to choose from"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            h5,
            const Center(
                child: Text(
              "Quiz Rules",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            h15,
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      "${quizRules[index]}",
                      style: const TextStyle(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.justify,
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButtonWidget(
                  text: "Start",
                  onPressed: () {
                    print("selected ${level}");
                  }),
            )
          ],
        ),
      )),
    );
  }
}

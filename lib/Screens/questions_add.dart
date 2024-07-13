import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Constants/sized_boxes.dart';
import 'package:quizapp/Widgets/textformfield_widget.dart';

class QuestionsAddScreeen extends StatelessWidget {
  QuestionsAddScreeen({super.key});
  final TextEditingController questionController = TextEditingController();
  final TextEditingController optionAController = TextEditingController();
  final TextEditingController optionBController = TextEditingController();
  final TextEditingController optionCController = TextEditingController();
  final TextEditingController optionDController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  List optionsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              h10,
              const Text(
                "Questions Upload Page",
                style: TextStyle(fontSize: 20),
              ),
              h10,
              TextFormFieldWidget(
                  hintText: "Question", controller: questionController),
              h10,
              TextFormFieldWidget(
                  hintText: "Option A", controller: optionAController),
              h10,
              TextFormFieldWidget(
                  hintText: "Option B", controller: optionBController),
              h10,
              TextFormFieldWidget(
                  hintText: "Option C", controller: optionCController),
              h10,
              TextFormFieldWidget(
                  hintText: "Option D", controller: optionDController),
              h10,
              TextFormFieldWidget(
                  hintText: "Correct Answer", controller: answerController),
              h10,
              // TextFormFieldWidget(
              //     hintText: "Category", controller: categoryController),
              // h10,
              // TextFormFieldWidget(
              //     hintText: "Level", controller: levelController),
              // h10,
              ElevatedButton(
                  onPressed: () async {
                    try {
                      optionsList.addAll([
                        optionAController.text,
                        optionBController.text,
                        optionCController.text,
                        optionDController.text
                      ]);
                      FirebaseFirestore.instance.collection('questions').add({
                        'question': questionController.text,
                        'options': optionsList,
                        'correctanswer': answerController.text,
                        'category': 'General Knowledge',
                        'level': 'Medium',
                      });
                      print("category added sucessfully");
                    } catch (e) {
                      print("Exception:${e}");
                    }
                    questionController.clear();
                    optionAController.clear();
                    optionBController.clear();
                    optionCController.clear();
                    optionDController.clear();
                    answerController.clear();
                    optionsList.clear();
                    // categoryController.clear();
                    // levelController.clear();
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      )),
    );
  }
}

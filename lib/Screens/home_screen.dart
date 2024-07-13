import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Constants/sized_boxes.dart';
import 'package:quizapp/Screens/quiz_rules.dart';
import 'package:quizapp/Widgets/elevatedButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else {
          final categoryList = snapshot.data;
          return SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quiz Genie",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                h5,
                const Text(
                  "Unlock Your Mind, Embrace the Challenge",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 123, 121, 121)),
                ),
                h20,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 8,
                              childAspectRatio: .85,
                              crossAxisCount: 2),
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 225, 215, 215)
                                            .withOpacity(0.5), // Shadow color
                                    spreadRadius: 1, // Spread radius
                                    offset: const Offset(0, 3), // Offset (X, Y)
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              categoryList![index]
                                                  ['category_image'])),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25)),
                                    ),
                                    width: double.infinity,
                                  ),
                                ),
                                h5,
                                SizedBox(
                                    // color: Colors.red,
                                    width: double.infinity,
                                    height: 55,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Center(
                                          child: Text(
                                        categoryList[index]['category'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: categoryList!.length,
                    ),
                  ),
                )
              ],
            ),
          ));
        }
      },
    ));
  }

  Future<List<Map<String, dynamic>>> getCategory() async {
    var categoryInstance = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await categoryInstance.collection('categories').get();
    final List<Map<String, dynamic>> categoryData = snapshot.docs.map((e) {
      return e.data() as Map<String, dynamic>;
    }).toList();
    return categoryData;
  }
}

void _showBottomSheet(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (BuildContext ctx) {
        return SizedBox(
          height: 250,
          width: double.infinity,
          child: Column(
            children: [
              h10,
              const Text(
                "Levels",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              h10,
              ElevatedButtonWidget(
                text: "Easy",
                onPressed: () {
                  Navigator.of(ctx)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return QuizRules(
                      level: 'Easy',
                    );
                  }));
                  print("Clicked easy");
                },
              ),
              h10,
              ElevatedButtonWidget(
                text: "Medium",
                onPressed: () {
                  Navigator.of(ctx)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return QuizRules(
                      level: 'Medium',
                    );
                  }));
                  print("Clicked Medium");
                },
              ),
              h10,
              ElevatedButtonWidget(
                text: "Hard",
                onPressed: () {
                  Navigator.of(ctx)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return QuizRules(
                      level: 'Hard',
                    );
                  }));
                  print("Clicked hard");
                },
              )
            ],
          ),
        );
      });
}

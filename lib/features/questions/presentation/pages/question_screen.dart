import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/data/models/questoin_model.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';
import 'package:whatif_project/firebase_functions.dart';
import 'dart:math';

class QuestionScreen extends StatefulWidget {
  TopicModel topicModel;

  QuestionScreen({super.key, required this.topicModel});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int index = 0;
  CluesModel? cluesModel;
  List<QuestionModel>? questions;
  bool check = false;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "WHAT IF?!",
          style: TextStyle(
              fontFamily: 'Jersey', color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .95,
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
        child: FutureBuilder<List<QuestionModel>>(
          future:
              FirebaseFunctions.getQuestionsForTopic(widget.topicModel.topicId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<QuestionModel>? questions = snapshot.data;
              if (questions != null && questions.isNotEmpty) {
                return Stack(
                  children: [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .35,
                        child: check == true
                            ? Text(
                                "No More Question",
                                style: TextStyle(
                                  fontFamily: 'Jersey',
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              )
                            : index == 5
                                ? Text(
                                    "Enough 5 Clues",
                                    style: TextStyle(
                                      fontFamily: 'Jersey',
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  )
                                : Text(
                                    "${questions[index].question}?!",
                                    style: TextStyle(
                                      fontFamily: 'Jersey',
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        check == true
                            ? Text(
                                "Let's discover a new story of \"what if?\"",
                                style: TextStyle(
                                  fontFamily: 'Jersey',
                                  color: Colors.green,
                                  fontSize: 35,
                                ),
                          textAlign: TextAlign.center,
                              )
                            : index == 5
                                ? Text(
                                    "Let's discover a new story of \"what if?\"",
                                    style: TextStyle(
                                      fontFamily: 'Jersey',
                                      color: Colors.green,
                                      fontSize: 35,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (index ==
                                                  questions.length - 1) {
                                                points[index] =
                                                    questions[index].question;
                                                check = true;
                                              } else {
                                                points[index] =
                                                    questions[index].question;
                                                index++;
                                              }
                                              print(points);
                                              setState(() {});
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7),
                                              decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: questions[index]
                                                          .choiceOne!
                                                          .isEmpty ||
                                                      questions[index]
                                                              .choiceOne ==
                                                          ""
                                                  ? Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          fontFamily: 'Jersey',
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    )
                                                  : Text(
                                                      questions[index]
                                                              .choiceOne ??
                                                          "Yes",
                                                      style: TextStyle(
                                                          fontFamily: 'Jersey',
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (index ==
                                                  questions.length - 1) {
                                              } else {
                                                index++;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7),
                                              decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: questions[index]
                                                          .choiceTwo!
                                                          .isEmpty ||
                                                      questions[index]
                                                              .choiceTwo ==
                                                          ""
                                                  ? Text(
                                                      "No",
                                                      style: TextStyle(
                                                          fontFamily: 'Jersey',
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    )
                                                  : Text(
                                                      questions[index]
                                                              .choiceTwo ??
                                                          "No",
                                                      style: TextStyle(
                                                          fontFamily: 'Jersey',
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (index == questions.length - 1) {
                                            index = 0;
                                          } else {
                                            index++;
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .85,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 7),
                                          decoration: BoxDecoration(
                                              color: Colors.orangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Skip",
                                            style: TextStyle(
                                                fontFamily: 'Jersey',
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.story,
                                arguments: CluesModel(
                                    topicTitle: widget.topicModel.topicTitle,
                                    clue1: points[0],
                                    clue2: points[1],
                                    clue3: points[2],
                                    clue4: points[3],
                                    clue5: points[4]));
                            index = 0;
                            check = false;
                            points.clear();
                            print(points);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .85,
                            padding: EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Get The Story",
                              style: TextStyle(
                                  fontFamily: 'Jersey',
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Text(
                  'Coming Soon...',
                  style: TextStyle(
                      fontSize: 35, fontFamily: 'Jersey', color: Colors.white),
                ));
              }
            }
          },
        ),
      ),
    );
  }

  List<String> points = [
    "",
    "",
    "",
    "",
    "",
  ];
}

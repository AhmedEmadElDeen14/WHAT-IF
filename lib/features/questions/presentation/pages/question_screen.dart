import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/data/models/questoin_model.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';
import 'package:whatif_project/firebase_functions.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatefulWidget {
  final TopicModel topicModel;

  QuestionScreen({super.key, required this.topicModel});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int index = 0;
  CluesModel? cluesModel;
  List<QuestionModel>? questions;
  bool check = false;
  bool isYes = true;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  void shuffleQuestions(List<QuestionModel> questions) {
    questions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/sky-black-background.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "WHAT IF?!",
            style: TextStyle(
                fontFamily: 'Jersey', color: Colors.white, fontSize: 35),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * .95,
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
          child: FutureBuilder<List<QuestionModel>>(
            future: FirebaseFunctions.getQuestionsForTopic(
                widget.topicModel.topicId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                questions = snapshot.data;
                if (questions != null && questions!.isNotEmpty) {
                  if (index == 0) {
                    shuffleQuestions(questions!);
                  }
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .35,
                          child: check == true
                              ? const Text(
                                  "No More Questions",
                                  style: TextStyle(
                                    fontFamily: 'Jersey',
                                    color: Colors.white,
                                    fontSize: 35,
                                  ),
                                )
                              : index == 5
                                  ? const Text(
                                      "5 Clues is Enough",
                                      style: TextStyle(
                                        fontFamily: 'Jersey',
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                    )
                                  : Text(
                                      "${questions![index].question}?!",
                                      style: const TextStyle(
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
                              ? const Text(
                                  "Let's discover a new story of \"what if?\"",
                                  style: TextStyle(
                                    fontFamily: 'Jersey',
                                    color: Colors.green,
                                    fontSize: 35,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : index == 5
                                  ? const Text(
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
                                                    questions!.length - 1) {
                                                  points[index] =
                                                      questions![index]
                                                          .question;
                                                  check = true;
                                                } else {
                                                  points[index] =
                                                      questions![index]
                                                          .question;
                                                  index++;
                                                }
                                                isYes = true;
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  isYes
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 7,
                                                          ),
                                                          child: const Image(
                                                            image: AssetImage(
                                                                "assets/images/alien monster.png"),
                                                            width: 25,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  Container(
                                                    child: questions![index]
                                                                .choiceOne!
                                                                .isEmpty ||
                                                            questions![index]
                                                                    .choiceOne ==
                                                                ""
                                                        ? const Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Jersey',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30),
                                                          )
                                                        : Text(
                                                            questions![index]
                                                                    .choiceOne ??
                                                                "Yes",
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'Jersey',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (index ==
                                                    questions!.length - 1) {
                                                  // Do nothing
                                                } else {
                                                  index++;
                                                }
                                                isYes = false;
                                                setState(() {});
                                              },
                                              child: Row(
                                                children: [
                                                  !isYes
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 7,
                                                          ),
                                                          child: const Image(
                                                            image: AssetImage(
                                                                "assets/images/alien monster.png"),
                                                            width: 25,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  Container(
                                                    child: questions![index]
                                                                .choiceTwo!
                                                                .isEmpty ||
                                                            questions![index]
                                                                    .choiceTwo ==
                                                                ""
                                                        ? const Text(
                                                            "No",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Jersey',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30),
                                                          )
                                                        : Text(
                                                            questions![index]
                                                                    .choiceTwo ??
                                                                "No",
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'Jersey',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                          indent: 15,
                                          endIndent: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (index ==
                                                questions!.length - 1) {
                                              index = 0;
                                            } else {
                                              index++;
                                            }
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Skip",
                                            style: TextStyle(
                                                fontFamily: 'Jersey',
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.story,
                                arguments: CluesModel(
                                  topicTitle: widget.topicModel.topicTitle,
                                  clue1: points[0],
                                  clue2: points[1],
                                  clue3: points[2],
                                  clue4: points[3],
                                  clue5: points[4],
                                ),
                              );
                              index = 0;
                              check = false;
                              points.clear();
                              print(points);
                            },
                            child: const Text(
                              "Get The Story",
                              style: TextStyle(
                                  fontFamily: 'Jersey',
                                  color: Color(0xffe93b2d),
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: Text(
                    'Coming Soon...',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Jersey',
                        color: Colors.white),
                  ));
                }
              }
            },
          ),
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

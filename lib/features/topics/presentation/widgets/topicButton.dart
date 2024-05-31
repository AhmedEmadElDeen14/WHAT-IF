// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';

class TopicButton extends StatelessWidget {
  String title;
  String topicId;
  TopicModel topicModel;

  TopicButton(
      {super.key,
      required this.title,
      required this.topicId,
      required this.topicModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(topicModel.topicTitle);
        Navigator.pushNamed(context, RoutesName.question,
            arguments: topicModel);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Jersey',
              color: Colors.white,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

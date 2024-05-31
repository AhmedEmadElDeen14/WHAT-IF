// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/topics/presentation/widgets/topicButton.dart';
// Import your Firebase functions

class TopicsScreen extends StatelessWidget {
  CategoryModel categoryModel;

  TopicsScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(
          categoryModel.categoryTitle,
          style: TextStyle(
            fontFamily: 'Jersey',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: categoryModel.topics == null || categoryModel.topics.isEmpty
          ? Center(
              child: Text(
              "Coming Soon...",
              style: TextStyle(
                  fontFamily: 'Jersey', fontSize: 55, color: Colors.white),
            ))
          : Container(
              padding: EdgeInsets.all(15),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Set the number of columns in the inner grid
                  crossAxisSpacing: 10.0, // Set the spacing between columns
                  mainAxisSpacing: 10.0, // Set the spacing between rows
                ),
                itemCount: categoryModel.topics.length,
                itemBuilder: (context, index) {
                  TopicModel topic = categoryModel.topics[index];
                  return TopicButton(
                    title: topic.topicTitle,
                    topicModel: categoryModel.topics[index],
                    topicId: topic.topicId,
                  );
                },
              )),
    );
  }
}

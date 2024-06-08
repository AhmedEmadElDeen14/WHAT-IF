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
          title: Text(
            categoryModel.categoryTitle,
            style: const TextStyle(
              fontFamily: 'Jersey',
              fontSize: 35,
              color: Color(0xfff4d23f),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: categoryModel.topics == null || categoryModel.topics.isEmpty
            ? const Center(
                child: Text(
                  "Coming Soon...",
                  style: TextStyle(
                      fontFamily: 'Jersey', fontSize: 55, color: Colors.white),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: categoryModel.topics.length,
                  itemBuilder: (context, index) {
                    TopicModel topic = categoryModel.topics[index];
                    return Row(
                      children: [
                        TopicButton(
                          title: topic.topicTitle,
                          topicModel: categoryModel.topics[index],
                          topicId: topic.topicId,
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}

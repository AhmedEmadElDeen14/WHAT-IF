// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/topics/presentation/widgets/topicButton.dart';

class TopicsScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  TopicsScreen({super.key, required this.categoryModel});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -100, end: 100).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          title: Text(
            widget.categoryModel.categoryTitle,
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
        body: widget.categoryModel.topics == null ||
                widget.categoryModel.topics.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Coming Soon...",
                      style: TextStyle(
                          fontFamily: 'Jersey',
                          fontSize: 55,
                          color: Colors.white),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_animation.value, 0),
                          child: child,
                        );
                      },
                      child: const Image(
                        image: AssetImage(
                          "assets/images/alien monster.png",
                        ),
                        width: 55,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: widget.categoryModel.topics.length,
                  itemBuilder: (context, index) {
                    TopicModel topic = widget.categoryModel.topics[index];
                    bool isFirstItem = index == 0;
                    return Row(
                      children: [
                        if (isFirstItem)
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.amber,
                            size: 25,
                          ),
                        TopicButton(
                          title: topic.topicTitle,
                          topicModel: widget.categoryModel.topics[index],
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

import 'package:flutter/material.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/data/models/questoin_model.dart';
import 'package:whatif_project/features/categories/presentation/pages/category.dart';
import 'package:whatif_project/features/home/presentation/pages/home.dart';
import 'package:whatif_project/features/info/presentation/pages/info_screen.dart';
import 'package:whatif_project/features/questions/presentation/pages/question_screen.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';
import 'package:whatif_project/features/story/presentation/pages/story.dart';
import 'package:whatif_project/features/topics/presentation/pages/topics.dart';

class RoutesName {
  static const String splash = "hh";
  static const String home = "/";
  static const String category = "category";
  static const String topics = "topics";
  static const String question = "question";
  static const String story = "story";
  static const String info = "info";
}

class AppRoutes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );case RoutesName.info:
        return MaterialPageRoute(
          builder: (context) => const InfoScreen(),
        );
      case RoutesName.category:
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      case RoutesName.topics:
        return MaterialPageRoute(
          builder: (context) => TopicsScreen(
            categoryModel: settings.arguments as CategoryModel,
          ),
        );
      case RoutesName.question:
        return MaterialPageRoute(
          builder: (context) => QuestionScreen(
            topicModel: settings.arguments as TopicModel,
          ),
        );
      case RoutesName.story:
        return MaterialPageRoute(
          builder: (context) => StoryScreen(
            cluesModel: settings.arguments as CluesModel,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => unDefineRoute(),
        );
    }
  }

  static Widget unDefineRoute() {
    return const Scaffold(
      body: Center(child: Text("Route Not Found")),
    );
  }
}

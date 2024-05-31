
import 'package:whatif_project/features/categories/data/models/questoin_model.dart';

class CategoryModel {
  String categoryId;
  String categoryTitle;
  List<TopicModel> topics;

  CategoryModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.topics,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var topicsList = json['topics'] as List;
    List<TopicModel> topics =
    topicsList.map((topicJson) => TopicModel.fromJson(topicJson)).toList();

    return CategoryModel(
      categoryId: json['categoryId'],
      categoryTitle: json['categoryTitle'],
      topics: topics,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> topicsJson =
    topics.map((topic) => topic.toJson()).toList();

    return {
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'topics': topicsJson,
    };
  }
}

class TopicModel {
  String topicTitle;
  String topicId;
  List<QuestionModel> questions;

  TopicModel({
    required this.topicTitle,
    required this.topicId,
    required this.questions,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    var questionsList = json['questions'] as List;
    List<QuestionModel> questions = questionsList
        .map((questionJson) => QuestionModel.fromJson(questionJson))
        .toList();

    return TopicModel(
      topicTitle: json['topicTitle'],
      topicId: json['topicId'],
      questions: questions,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> questionsJson =
    questions.map((question) => question.toJson()).toList();

    return {
      'topicTitle': topicTitle,
      'topicId': topicId,
      'questions': questionsJson,
    };
  }
}


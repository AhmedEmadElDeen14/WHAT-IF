import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/data/models/questoin_model.dart';

class FirebaseFunctions {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.categoryId).set({
      'categoryTitle': category.categoryTitle,

    });
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('Category').get();

    List<Future<CategoryModel>> categoriesFutures = querySnapshot.docs.map((doc) async {
      String categoryId = doc.id;
      List<TopicModel> topics = await _getTopicsForCategory(categoryId);

      return CategoryModel(
        categoryId: categoryId,
        categoryTitle: doc['categoryTitle'],
        topics: topics,
      );
    }).toList();

    return Future.wait(categoriesFutures);
  }

  static Future<List<TopicModel>> _getTopicsForCategory(String categoryId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Category')
        .doc(categoryId)
        .collection('Topic')
        .get();

    return querySnapshot.docs.map((doc) {
      return TopicModel(
        topicId: doc.id,
        topicTitle: doc['topicTitle'],
        questions: [], // We'll fetch questions separately
      );
    }).toList();
  }

  static Future<List<QuestionModel>> getQuestionsForTopic( String topicId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Category')
        .doc("Ewq3GmaBuZPhFhwaUmhL")
        .collection('Topic')
        .doc(topicId)
        .collection('Question')
        .get();

    return querySnapshot.docs.map((doc) {
      return QuestionModel(
        question: doc['question'],
        choiceOne: doc['choiceOne'],
        choiceTwo: doc['choiceTwo'],
      );
    }).toList();
  }

// Other functions for adding topics, questions, etc.
}

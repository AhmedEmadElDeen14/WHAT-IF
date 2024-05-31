import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/firebase_functions.dart';

class CategoryButton extends StatelessWidget {
  String title;
  String categoryId;
  CategoryModel categoryModel;

  CategoryButton(
      {super.key,
      required this.title,
      required this.categoryId,
      required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(categoryModel.categoryTitle);
        Navigator.pushNamed(context, RoutesName.topics,
            arguments: categoryModel);
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

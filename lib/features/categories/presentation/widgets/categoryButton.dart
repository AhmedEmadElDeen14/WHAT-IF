import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';

// ignore: must_be_immutable
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
        Navigator.pushNamed(context, RoutesName.topics,
            arguments: categoryModel);
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title == "Sport"
                ? const Icon(
                    Icons.play_arrow,
                    color: Colors.amber,
                    size: 25,
                  )
                : const SizedBox(),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Jersey',
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

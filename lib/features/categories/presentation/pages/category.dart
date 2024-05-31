import 'package:flutter/material.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/presentation/widgets/categoryButton.dart';
import 'package:whatif_project/firebase_functions.dart'; // Import your Firebase functions

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder<List<CategoryModel>>(
          future: FirebaseFunctions.getAllCategories(),
          // Fetch categories from Firebase
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<CategoryModel>? categories = snapshot.data;
              if (categories != null && categories.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of columns in the grid
                    crossAxisSpacing: 30.0, // Set the spacing between columns
                    mainAxisSpacing: 30.0, // Set the spacing between rows
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories[index];
                    return CategoryButton(
                      title: category.categoryTitle,
                      categoryId: category.categoryId,
                      categoryModel: category,
                    );
                  },
                );
              } else {
                return Center(child: Text('No categories found.'));
              }
            }
          },
        ),
      ),
    );
  }
}

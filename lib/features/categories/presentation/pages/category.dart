import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatif_project/features/categories/data/models/category_model.dart';
import 'package:whatif_project/features/categories/presentation/widgets/categoryButton.dart';
import 'package:whatif_project/firebase_functions.dart'; // Import your Firebase functions

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCirc,
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
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: FutureBuilder<List<CategoryModel>>(
            future: FirebaseFunctions.getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
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
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<CategoryModel>? categories = snapshot.data;
                if (categories != null && categories.isNotEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const Text(
                          "What's your Fav ?!",
                          style: TextStyle(
                            fontFamily: 'Jersey',
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
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
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No categories found.'));
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

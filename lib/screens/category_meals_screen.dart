import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const String routeName = '/category-meal';

  final List<Meal> avaiableMeals;

  CategoryMealsScreen(this.avaiableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedInitData = false;

  @override
  // it loaded all the data before the build() runs,
  void didChangeDependencies() {
    // it makes sure it only load the data at the first time (when the screen is still existed),
    // when the screen is not existed, and recreate again, this will runs again for the first time of that newly created page
    if(!_loadedInitData) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;

      // 'title' and 'id' is the key on routerArgs, and return the value based on that key and store on a variable
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = widget.avaiableMeals.where((meal) {
        // it makes sure that each category only contains same id that item has
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displayMeals[index].id,
                title: displayMeals[index].title,
                imageUrl: displayMeals[index].imageUrl,
                duration: displayMeals[index].duration,
                affordability: displayMeals[index].affordability,
                complexity: displayMeals[index].complexity,
            );
          },
          itemCount: displayMeals.length,
        )
    );
  }
}

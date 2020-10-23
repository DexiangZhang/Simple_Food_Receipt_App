import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() {
  runApp(FoodRecipeApp());
}

class FoodRecipeApp extends StatefulWidget {
  @override
  _FoodRecipeAppState createState() => _FoodRecipeAppState();
}

class _FoodRecipeAppState extends State<FoodRecipeApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avaiableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _avaiableMeals = DUMMY_MEALS.where((meal) {
        // exclude the meal that has gluten, lactose, vegan, vegetarian on it
        /* ex: if user make gluten switch on, it means only show that item that
        has gluten
         */
        if(_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();

    });
  }

  void _toggleFavorite(String mealId) {

    // if item already exits in the list, it will return index, if not in list, return -1;
    final existingIndex =
      _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >=0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',

        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 23,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        )
      ),

      // the first screen, or the root screen of the app
      initialRoute: '/',    // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_avaiableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
    );
  }
}


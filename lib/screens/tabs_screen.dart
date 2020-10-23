import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  // this is for body part, so you can display different screen based on the tap
  // Object means you don't know what type of value is actually
  List<Map<String, Object>> _pages;

  // this is for update our index, so the screen is updated when click different tab
  int _selectPageIndex = 0;

  /* widget can be use in "initial()" "build()" but not with variable when you initial variable,
      ex:  var x = widget.xxx      since when the application run to this part,
      it is not avaiable yet to use "widget.xxx"
   */
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'My Favorites',
      },
    ];

    super.initState();
  }
  // flutter gives your the index, so you know which tap is click
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,

          /* required to make "unselectedItemColor"  and "selectedItemColor" working
          properly since it tells tabBar which index is currently in
           */
          currentIndex: _selectPageIndex,

          //each BottomNavigationBarItem is representing each tab
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("Categories"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favorites"),
            ),
          ],
        ),
      );
  }
}

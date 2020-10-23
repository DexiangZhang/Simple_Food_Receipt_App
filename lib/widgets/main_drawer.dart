import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  final String backgroundUrl =
      'https://envato-shoebox-0.imgix.net/60f1/c8ef-12cd-46d5-ae2a-90755b28939b/1-05119.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=700&s=32337ec75aa290ee2b92498326acdcf1';

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                backgroundUrl,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  'Cooking Up!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          buildListTile(
            "Meals Menu",
            Icons.restaurant,
              // this is anymous function
            () {
                // '/' this is setup in the main file, which represent tapScreen
                Navigator.of(context).pushReplacementNamed('/');
              }
          ),
          buildListTile(
            "Filters",
            Icons.settings,
            // this is anymous function
            () {
                Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
              }
          ),
        ],
      ),
    );
  }
}

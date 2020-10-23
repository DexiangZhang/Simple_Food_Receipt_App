import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {

  static const routeName = '/filters';

  final Function saveFilterSetup;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilterSetup);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {

              final selectFilters  =  {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };

              widget.saveFilterSetup(selectFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust Your Meal Selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    "Gluten-free",
                    "Only include gluten-free meals",
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }
                 ),
                _buildSwitchListTile(
                    "Lactose-free",
                    "Only include lactose-free meals",
                    _lactoseFree,
                        (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }
                ),
                _buildSwitchListTile(
                    "Vegetarian",
                    "Only include vegetarian meals",
                    _vegetarian,
                        (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }
                ),
                _buildSwitchListTile(
                    "Vegan",
                    "Only include egan meals",
                    _vegan,
                        (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

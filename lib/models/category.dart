import 'package:flutter/material.dart';

class Category {

  final String id;
  final String title;
  final Color color;

  // using name argument with ({}), we can initial default value like this
  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange
  });
}
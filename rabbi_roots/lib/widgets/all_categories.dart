import 'package:flutter/material.dart';
import 'package:rabbi_roots/models/category.dart' as model;
import 'package:rabbi_roots/screens/home_screen.dart';
import 'package:rabbi_roots/widgets/category_card.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate fetching the full list of categories
    List<Category> categories = fetchCategoriesFromBackend();

    return Scaffold(
      appBar: AppBar(title: Text('All Categories')),
      body: CategoryList(categories: categories),
    );
  }
}

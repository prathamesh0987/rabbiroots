import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';

class CategoryProvider with ChangeNotifier {
  final ApiService apiService;
  List<Category> _categories = [];
  bool _isLoading = false;

  CategoryProvider({required this.apiService});

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await apiService.fetchCategories();
    } catch (e) {
      print('Error fetching categories: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService apiService;
  List<Product> _products = [];
  bool _isLoading = false;

  ProductProvider({required this.apiService});

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Fetch products as a List<dynamic> and convert each item to a Product
      final productList = await apiService.fetchProducts();
      _products = productList
          .map((productData) => Product.fromJson(productData))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}

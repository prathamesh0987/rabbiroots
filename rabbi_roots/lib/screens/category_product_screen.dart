// lib/screens/category_products_screen.dart

import 'package:flutter/material.dart';
import 'package:rabbi_roots/services/api_service.dart'; // Import the ApiService
import 'package:rabbi_roots/widgets/product_card_sub.dart'; // Assuming the ProductCard widget is inside this file
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:rabbi_roots/screens/checkout_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final List<String> subcategories;

  const CategoryProductsScreen({
    required this.categoryId,
    required this.categoryName,
    required this.subcategories,
  });

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isLoading = true;
  List<String> subcategories = [];
  String selectedSubcategory = "All";
  List<Map<String, dynamic>> allProducts = [];

  // Simulated product data
  List<Map<String, dynamic>> dummyProducts = [
    {
      "name": "Patanjali Whole",
      "weight": "10kg",
      "price": 249,
      "mrp": 300,
      "discount": 51,
      "deliveryTime": "20 mins",
      "subcategory": "Atta",
      "imageUrl": "assets/test.jpg",
    },
    {
      "name": "Spinach",
      "weight": "10kg",
      "price": 18,
      "mrp": 75,
      "discount": 57,
      "deliveryTime": "20 mins",
      "subcategory": "Fresh Vegetables",
      "imageUrl": "assets/test.jpg",
    },
    {
      "name": "Cauliflower",
      "weight": "10kg",
      "price": 28,
      "mrp": 60,
      "discount": 32,
      "deliveryTime": "20 mins",
      "subcategory": "Seasonal Picks",
      "imageUrl": "assets/test.jpg",
    },
    {
      "name": "Apple",
      "weight": "10kg",
      "price": 120,
      "mrp": 150,
      "discount": 30,
      "deliveryTime": "20 mins",
      "subcategory": "Fresh Fruits",
      "imageUrl": "assets/test.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  // Fetch subcategories by calling the ApiService
  Future<void> fetchSubcategories() async {
    try {
      final fetchedSubcategories =
          await ApiService().fetchSubcategories(widget.categoryId);
      setState(() {
        subcategories = fetchedSubcategories;
        setState(() {
          // Use dummy subcategories instead of fetching from the API
          subcategories = [
            "Fresh Vegetables",
            "Fresh Fruits",
            "Seasonal Picks",
            "Atta",
            "Spices",
            "Dried Fruits",
          ];
          isLoading = false; // Set loading to false to show the UI
        });
      });
    } catch (e) {
      print("Error fetching subcategories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = selectedSubcategory == "All"
        ? dummyProducts
        : dummyProducts
            .where((product) => product["subcategory"] == selectedSubcategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Row(
        children: [
          // Sidebar for Subcategories
          isLoading ? buildShimmerSidebar() : buildSubcategorySidebar(),

          // Product Grid
          Expanded(
            child: isLoading
                ? buildShimmerProductGrid()
                : buildProductGrid(filteredProducts),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomButton(),
    );
  }

  // Build sidebar with subcategories
  Widget buildShimmerSidebar() {
    return Container(
      width: 80,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              height: 60,
            ),
          );
        },
      ),
    );
  }

  // Build sidebar with actual subcategories
// Sidebar with actual subcategories (or dummy ones if the API call fails or is skipped)
  Widget buildSubcategorySidebar() {
    return Container(
      width: 80,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          String subcategory = subcategories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSubcategory =
                    subcategory; // Update selected subcategory
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: selectedSubcategory == subcategory
                    ? Colors.green.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Image.asset(
                      "assets/atta.png", // Replace with actual subcategory icons if needed
                      height: 30,
                      width: 30,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subcategory,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: selectedSubcategory == subcategory
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Build the shimmer grid for products
  Widget buildShimmerProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }

  // Build the product grid with actual data
  Widget buildProductGrid(List<Map<String, dynamic>> products) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imageUrl: product["imageUrl"],
          weight: product["weight"],
          productName: product["name"],
          deliveryTime: product["deliveryTime"],
          price: product["price"],
          mrp: product["mrp"],
        );
      },
    );
  }

  // Continue Button at the bottom
  Widget buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {
            // Handle the continue button action
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutScreen()),
            );
          },
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

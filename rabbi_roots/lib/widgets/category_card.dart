import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/checkout_screen.dart';
import 'package:rabbi_roots/widgets/product_detail_modal.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final ProductCardScreen productCardScreen = ProductCardScreen();

  CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio:
            1.0, // Adjust aspect ratio to make the card look better
      ),
      itemCount:
          categories.length, // Dynamically use the length of categories list
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Handle card click here
              // You can navigate to another screen with more details
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => productCardScreen),
              );
              // productCardScreen;
            },
            child: CategoryCard(category: categories[index]),
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image
        Card(
          color: Colors.white,
          // Padding around the image
          child: Image.asset(
            category.imageUrl, // The image URL provided in Category
            width: double.infinity,
            height: 150,
            fit: BoxFit.contain, // Ensure image maintains aspect ratio
          ),
        ),
        const SizedBox(height: 8), // Space between image and text
        // Category name
        Text(
          category.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

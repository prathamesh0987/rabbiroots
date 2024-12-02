import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/all_products_screen.dart';
import 'package:rabbi_roots/widgets/all_categories.dart';
import 'package:rabbi_roots/widgets/all_products_section.dart';
import 'package:rabbi_roots/widgets/delivery_section.dart';
import 'package:rabbi_roots/widgets/free_delivery_banner.dart';
import '../widgets/search_bar.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/section_header.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';

List<Category> fetchCategoriesFromBackend() {
  // Simulating backend data fetch (replace this with your actual backend call)
  return [
    Category(name: "Atta, Rice & Dal", imageUrl: "assets/atta.png"),
    Category(name: "Oil, Ghee & Masala", imageUrl: "assets/bakery.png"),
    Category(name: "Dairy & Bread", imageUrl: "assets/sweet.png"),
    Category(name: "Bakery & Biscuit", imageUrl: "assets/oil.png"),
    Category(name: "Frozen Foods", imageUrl: "assets/atta.png"),
    Category(name: "Beverages", imageUrl: "assets/oil.png"),
    Category(name: "Snacks", imageUrl: "assets/sweet.png"),
  ];
}

List<Product> fetchProductsFromBackend() {
  return [
    Product(name: "Product 1", imageUrl: "assets/atta.png"),
    Product(name: "Product 2", imageUrl: "assets/bakery.png"),
    Product(name: "Product 3", imageUrl: "assets/sweet.png"),
    Product(name: "Product 4", imageUrl: "assets/oil.png"),
    Product(name: "Product 5", imageUrl: "assets/atta.png"),
    Product(name: "Product 6", imageUrl: "assets/oil.png"),
    Product(name: "Product 7", imageUrl: "assets/sweet.png"),
    Product(name: "Product 8", imageUrl: "assets/bakery.png"),
  ];
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _showAllCategories = false;
  bool _showAllProducts = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch categories and products inside the build method
    List<Category> categories = fetchCategoriesFromBackend();
    List<Product> products = fetchProductsFromBackend();

    // Displayed categories and products based on the flag
    List<Category> displayedCategories =
        _showAllCategories ? categories : categories.sublist(0, 4);

    List<Product> displayedProducts =
        _showAllProducts ? products : products.sublist(0, 6);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(child: DeliverySection()),
          SliverToBoxAdapter(child: SearchBar1()),
          SliverToBoxAdapter(child: BannerCarousel()),

          // Grocery & Kitchen Section
          SliverToBoxAdapter(
            child: SectionHeader(
                title: 'Grocery & Kitchen',
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCategoriesScreen(),
                    ),
                  );
                }),
          ),
          SliverToBoxAdapter(
            child: CategoryList(
                categories:
                    displayedCategories), // Pass displayed categories here
          ),

          SliverToBoxAdapter(
            child: AllProductsHeader(),
          ),

          // All Products Section
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'All Products',
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllProductsScreen(),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ProductGrid(products: displayedProducts),
          ),

          // Option to see all categories or products
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/all_products_screen.dart';
import 'package:rabbi_roots/screens/category_product_screen.dart';
import 'package:rabbi_roots/screens/past_order_screen.dart';
import 'package:rabbi_roots/screens/profile/profile_screen.dart';
import 'package:rabbi_roots/screens/wishlist_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/widgets/all_categories.dart';
import 'package:rabbi_roots/widgets/delivery_section.dart';
import 'package:rabbi_roots/widgets/search_bar.dart';
import 'package:rabbi_roots/widgets/banner_view.dart';
import 'package:rabbi_roots/widgets/section_header.dart';
import 'package:rabbi_roots/widgets/category_card.dart';
import 'package:rabbi_roots/widgets/product_card.dart';

import '../models/category2.dart';

// API Service instance
final ApiService apiService = ApiService();

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTabScreen(),
    PastOrdersScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            // Top Padding
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            // Delivery Section
            const SliverToBoxAdapter(child: DeliverySection()),
            // Search Bar
            SliverToBoxAdapter(child: SearchBar1()),
            // Banner Section
            const SliverToBoxAdapter(child: BannerView(isFeatured: false)),

            // Categories Section
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
                },
              ),
            ),
            // Add space between the section header and the grid
            const SliverToBoxAdapter(
                child: SizedBox(height: 16)), // Adjust height here

            FutureBuilder<List<Category>>(
              future: apiService.fetchCategoriesFromBackend(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                              'Failed to load categories: ${snapshot.error}')));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text('No categories available')));
                }

                // Limit the categories to the first 8
                final categories = snapshot.data!.take(8).toList();

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        4, // Adjust to the number of columns you want
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 2, // Vertical space between grid items
                    crossAxisSpacing: 2, // Horizontal space between grid items
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                      onTap: () {
                        // Navigate to a screen with category details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              categoryId: categories[index].id,
                              categoryName: categories[index].name,
                              subcategories: categories[index].subcategories,
                            ),
                          ),
                        );
                      },
                      child: CategoryCard(category: categories[index]),
                    ),
                    childCount: categories.length,
                  ),
                );
              },
            ),

            // You can add more sections here...
          ],
        ),
      ),
    );
  }
}

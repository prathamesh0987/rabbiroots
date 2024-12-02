import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/category_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';
import 'services/api_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: 'https://your-api-endpoint.com');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CategoryProvider(apiService: apiService)),
        ChangeNotifierProvider(
            create: (_) => ProductProvider(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
        home: HomeScreen(),
      ),
    );
  }
}

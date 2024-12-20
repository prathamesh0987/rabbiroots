import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rabbi_roots/models/category2.dart';
import 'package:rabbi_roots/widgets/category_card.dart';

class ApiService {
  final String baseUrl = "https://rabbiroots.com/APP";
  final String signUpUrl = 'https://rabbiroots.com/APP/signup.php';
  final String verifyOtpUrl =
      'https://rabbiroots.com/APP/signup_verification.php';

  // Helper function to handle the API request and error
  Future<Map<String, dynamic>> _apiRequest(
      String url, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Failed to connect to the server"
        };
      }
    } catch (e) {
      print("Error: $e");
      return {"status": "error", "message": e.toString()};
    }
  }

  // Sign-up API call
  Future<Map<String, dynamic>> signUp(
      String name, String email, String mobile, String password) async {
    Map<String, String> requestBody = {
      "name": name,
      "email": email,
      "mobile_no": mobile,
      "password": password,
    };

    return await _apiRequest(signUpUrl, requestBody);
  }

  // OTP verification API call
  Future<Map<String, dynamic>> verifyOtp(String regNo, String flag) async {
    Map<String, String> requestBody = {
      "reg_no": regNo,
      "flag": flag,
    };

    return await _apiRequest(verifyOtpUrl, requestBody);
  }

  // Sign-in API call
  Future<Map<String, dynamic>> signin(String username, String password) async {
    Map<String, String> requestBody = {
      "username": username,
      "password": password,
    };

    return await _apiRequest('$baseUrl/signin.php', requestBody);
  }

  // Fetch categories dynamically
  Future<List<Category>> fetchCategoriesFromBackend() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/category.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"key": "Active"}),
      );
      print('Categories response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> responseList = data['responce'] ?? [];

        return responseList.map((item) {
          final String id = item['id'] ?? '';
          final String name = item['category_title'] ?? '';
          final String filepath = item['filepath'] ?? '';
          final String imageUrl = filepath.isEmpty || filepath == "0"
              ? 'https://s3-alpha-sig.figma.com/img/5e81/c388/51c2f3de445c143768ab21d1745eccfb?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Coi5v9K9Mjnhghjja0V519RypfIjyYhKOJl6~xOCex582fGdDaqrRMVNVR3NwNc2tL1kmE9C-a-y0~psfJ9BjjBp1i8GZ6NrO93Q6fW941qRC~tER-QBBfKl8cPFnXME198ZM2lsAUlEjHLUYyzLVMtcFMXKQwNKNE94enyalXtn~A~mUL-8kImoFPhloRT0yipEkG1K7knRAceJuT-RtGSKhhAsDqm~l-BkXkmtATsXLYWsDTOPZ6L4pO6y4DTVa8kCWBumLN4RBnit788WGQJsblU5vlyBQDhQnx97r1gTKPZ~tKoRZ557GxMoCkysGNGANqKMqfED-RAG4Ivkug__'
              : filepath; // API image URL

          return Category(
            name: name,
            imageUrl: imageUrl,
            subcategories: [], id: id, // Populate subcategories if needed
          );
        }).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  // Fetch subcategories dynamically
  Future<List<String>> fetchSubcategories(String categoryId) async {
    try {
      final body = {
        'key': 'Active', // 'Active' or 'All'
        'cat_id': categoryId,
      };
      print(body);

      final response = await http.post(
        Uri.parse('$baseUrl/subCategory.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('subcategories')) {
          return List<String>.from(data['subcategories']);
        } else {
          throw Exception('Subcategories not found in the response');
        }
      } else {
        throw Exception('Failed to load subcategories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
      return [];
    }
  }
}

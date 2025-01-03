import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/otp_verification_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _otp;
  String? _reg_no;

  final ApiService _apiService = ApiService();

  // Error messages for validation
  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top image
              Stack(
                children: [
                  Image.asset(
                    'assets/sign_up.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),

              // Form Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sign Up Text
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          errorText: _nameError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Email Field
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email-id",
                          errorText: _emailError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Mobile Field
                      TextField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Mobile No.",
                          errorText: _mobileError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          errorText: _passwordError,
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Confirm Password Field
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          errorText: _confirmPasswordError,
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Error message if any
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      // OTP message if sign-up is successful
                      if (_otp != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'OTP: $_otp',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                      // Sign-Up Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE4572E),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Validate all inputs
  bool _validateInputs() {
    bool isValid = true;

    // Reset error messages
    setState(() {
      _nameError = null;
      _emailError = null;
      _mobileError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    // Validate name
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Please enter your name';
      });
      isValid = false;
    }

    // Validate email
    if (_emailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(_emailController.text)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      isValid = false;
    }

    // Validate mobile number
    if (_mobileController.text.isEmpty || _mobileController.text.length < 10) {
      setState(() {
        _mobileError = 'Please enter a valid mobile number';
      });
      isValid = false;
    }

    // Validate password
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters long';
      });
      isValid = false;
    }

    // Validate confirm password
    if (_confirmPasswordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      isValid = false;
    }

    return isValid;
  }

  // Sign-up method
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Validate inputs
    if (!_validateInputs()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Call the sign-up API
    final response = await _apiService.signUp(
      _nameController.text,
      _emailController.text,
      _mobileController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    // Handle the API response
    if (response['responce'][0]['status'] == 'okay') {
      setState(() {
        _otp = response['responce'][0]['otp']; // Extract OTP from response
        _reg_no = response['responce'][0]['reg_no'];
        _errorMessage = null;
      });

      // Navigate to OTP Verification Screen after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            otp: _otp!,
            mobileNo: _mobileController.text,
            reg_no: _reg_no!,
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage = response['responce'][0]['status'] ??
            'An error occurred, please try again.';
        _otp = null;
        _reg_no = null;
      });
    }
  }
}

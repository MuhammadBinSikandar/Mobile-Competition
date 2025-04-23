import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/GettingStarted.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final baseUrl = 'http://10.113.81.121:8000';
  bool isLoading = false;
  final Color primaryColor = const Color.fromARGB(255, 12, 47, 101);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  InputDecoration getInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Show a snackbar or alert if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    setState(() {
      isLoading = true; // Start loading spinner
    });

    // Preparing data to be sent to the API
    final Map<String, dynamic> loginData = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginData),
      );

      // Debugging: print the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      setState(() {
        isLoading = false; // Stop loading spinner
      });

      if (response.statusCode == 200) {
        // If the response is successful (HTTP 200)
        final responseData = jsonDecode(response.body);
        final String token =
            responseData['token']; // Assuming the API returns a 'token'

        // Save the token locally
        await saveToken(token);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));

        // Navigate to home screen or main app screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetStarted(),
          ), // Replace with your home screen
        );
      } else {
        // If there was an error in the response (e.g., wrong credentials)
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Error occurred')),
        );
      }
    } catch (error) {
      // Handle network errors
      setState(() {
        isLoading = false;
      });
      print('Error: $error'); // Print the error message for debugging
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network Error. Please try again later.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check if the user is logged in
  }

  void checkLoginStatus() async {
    final token = await getToken();
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GetStarted(),
        ), // Replace with your home screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login to Your Account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 32.0),

            /// Form
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: getInputDecoration("Email", Icons.email),
                  ),
                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration(
                      "Password",
                      Icons.lock,
                    ).copyWith(suffixIcon: Icon(Icons.visibility_off)),
                  ),
                  SizedBox(height: 32.0),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : loginUser,
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                              : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ), // Ensure the text is always white
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

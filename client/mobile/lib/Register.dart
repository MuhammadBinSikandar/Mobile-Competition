import 'dart:convert'; // For encoding JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final baseUrl = 'http://10.113.81.121:8000'; // Your base URL
  bool agreeToTerms = false;

  final Color primaryColor = const Color.fromARGB(255, 12, 47, 101);
  final Color buttonTextColor = Colors.white;

  // Local constants
  final double spaceBtwItems = 8.0;
  final double spaceBtwInputFields = 16.0;
  final double spaceBtwSections = 32.0;

  final String firstName = "First Name";
  final String lastName = "Last Name";
  final String username = "Username";
  final String email = "Email";
  final String password = "Password";
  final String iAgreeTo = "I agree to";
  final String privacyPolicy = "Privacy Policy";
  final String and = "and";
  final String termsOfUse = "Terms of Use";
  final String createAccount = "Create Account";

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
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

  Future<void> registerUser() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      // Show a snackbar or alert if any field is empty
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // Preparing data to be sent to the API
    final Map<String, dynamic> userData = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful!')),
        );
      } else {
        // Handle error (e.g., show the error message)
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Error occurred')),
        );
      }
    } catch (error) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network Error. Please try again later.')),
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
              "Create Your Account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: spaceBtwSections),

            /// Form
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: getInputDecoration(
                            firstName,
                            Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(width: spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: getInputDecoration(
                            lastName,
                            Icons.person,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBtwInputFields),

                  TextFormField(
                    controller: usernameController,
                    decoration: getInputDecoration(username, Icons.edit),
                  ),
                  SizedBox(height: spaceBtwInputFields),

                  TextFormField(
                    controller: emailController,
                    decoration: getInputDecoration(email, Icons.email),
                  ),
                  SizedBox(height: spaceBtwInputFields),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration(
                      password,
                      Icons.lock,
                    ).copyWith(suffixIcon: Icon(Icons.visibility_off)),
                  ),
                  SizedBox(height: spaceBtwSections),

                  /// Terms and Conditions Checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          activeColor: primaryColor,
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: spaceBtwItems),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "$iAgreeTo ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: "$privacyPolicy ",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.apply(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: "$and ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: termsOfUse,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.apply(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBtwSections),

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
                      onPressed: agreeToTerms ? registerUser : null,
                      child: Text(
                        createAccount,
                        style: TextStyle(
                          color: agreeToTerms ? Colors.white : Colors.black,
                        ),
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

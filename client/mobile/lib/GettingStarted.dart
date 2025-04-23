import 'package:flutter/material.dart';
import 'package:mobile/Register.dart';
import 'package:mobile/Signin.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F4F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              /// Illustration
              const CourseIllustration(),

              const SizedBox(height: 32),

              /// Title
              const Text(
                'Unlock Knowledge with EdHub Courses',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              /// Description
              const Text(
                'Create, enroll, and learn through AI-powered micro-courses for a personalized experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
              ),

              const Spacer(),

              /// Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          12,
                          47,
                          101,
                        ), // Custom dark blue
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(
                          255,
                          12,
                          47,
                          101,
                        ), // Text color
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: const BorderSide(
                          color: Color.fromARGB(
                            255,
                            12,
                            47,
                            101,
                          ), // Border color
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseIllustration extends StatelessWidget {
  const CourseIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/logo.png'), // Make sure the path is correct
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ), // Shadow color with some transparency
            offset: const Offset(0, 4), // Shadow offset
            blurRadius: 10, // How blurry the shadow is
            spreadRadius: 2, // How much the shadow spreads
          ),
        ],
      ),
    );
  }
}

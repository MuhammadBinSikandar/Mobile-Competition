import 'package:flutter/material.dart';
import 'package:mobile/screens/tutor/widgets/custom_widgets.dart';
// Importing custom widgets

class CourseCreationScreen extends StatelessWidget {
  const CourseCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromRGBO(12, 47, 101, 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create Course',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Course Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(label: 'Course Title', icon: Icons.title),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Course Description',
              icon: Icons.description,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Duration (in weeks)',
              icon: Icons.access_time,
            ),
            const SizedBox(height: 24),
            CustomButton(
              primaryColor: primaryColor,
              buttonText: 'Create Course',
            ),
          ],
        ),
      ),
    );
  }
}

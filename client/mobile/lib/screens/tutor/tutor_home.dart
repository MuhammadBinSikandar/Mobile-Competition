import 'package:flutter/material.dart';
import 'package:mobile/screens/tutor/ai_enhancements.dart';
import 'package:mobile/screens/tutor/micro_lesson_upload.dart';
import 'dashboard_screen.dart';
import 'course_creation_screen.dart';

class TutorHome extends StatefulWidget {
  const TutorHome({super.key});

  @override
  _TutorHomeState createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    TutorDashboardScreen(),
    CourseCreationScreen(),
    MicroLessonUploadScreen(),
    AIEnhancementScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Color.fromRGBO(12, 47, 101, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create Course',
            backgroundColor: Color.fromRGBO(12, 47, 101, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload Lesson',
            backgroundColor: Color.fromRGBO(12, 47, 101, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'AI Tools',
            backgroundColor: Color.fromRGBO(12, 47, 101, 1),
          ),
        ],
      ),
    );
  }
}

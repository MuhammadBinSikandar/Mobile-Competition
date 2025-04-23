import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TutorHome(), debugShowCheckedModeBanner: false));
}

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
    PeerQAScreen(),
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
        selectedItemColor: Colors.white, // Color for selected icons
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(
          color: Colors.white, // Color of selected item icon
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey, // Color of unselected item icon
        ),
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Color.fromRGBO(
              12,
              47,
              101,
              1,
            ), // background for selected button
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
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Q&A Wall',
            backgroundColor: Color.fromRGBO(12, 47, 101, 1),
          ),
        ],
      ),
    );
  }
}

class TutorDashboardScreen extends StatelessWidget {
  final Color primaryColor = const Color.fromRGBO(12, 47, 101, 1);

  const TutorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tutor Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildStatCard(
                    'Total Courses',
                    '5',
                    Icons.book,
                    primaryColor,
                  ),
                  _buildStatCard(
                    'Enrolled Students',
                    '120',
                    Icons.people,
                    primaryColor,
                  ),
                  _buildStatCard(
                    'Average Rating',
                    '4.5',
                    Icons.star,
                    primaryColor,
                  ),
                  _buildStatCard(
                    'Total Revenue',
                    '\$1,200',
                    Icons.monetization_on,
                    primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Graph/Chart Placeholder',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActivityTile('Uploaded "Intro to AI" Micro-Lesson'),
                  _buildActivityTile(
                    'Answered a student query on "Machine Learning"',
                  ),
                  _buildActivityTile(
                    'Created a new course "Flutter for Beginners"',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile(String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: primaryColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder screens for navigation (to be implemented)
class CourseCreationScreen extends StatelessWidget {
  const CourseCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Course Creation Screen')));
  }
}

class MicroLessonUploadScreen extends StatelessWidget {
  const MicroLessonUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Micro-Lesson Upload Screen')));
  }
}

class AIEnhancementScreen extends StatelessWidget {
  const AIEnhancementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('AI Enhancement Screen')));
  }
}

class PeerQAScreen extends StatelessWidget {
  const PeerQAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Peer Q&A Wall Screen')));
  }
}

import 'package:flutter/material.dart';
import 'package:mobile/GettingStarted.dart';
import 'package:mobile/Register.dart';
import 'package:mobile/screens/student/student_dashboard';
import 'package:mobile/screens/tutor/tutor_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUpScreen());
  }
}

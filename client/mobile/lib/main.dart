import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mraduvdfjlgwsksoisuy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yYWR1dmRmamxnd3Nrc29pc3V5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzODU4MjUsImV4cCI6MjA2MDk2MTgyNX0.QQrHe9v8Xj_NnxyAAEM4PR9RiSwtq-p0qFxrz1NWoSk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My App')),
        body: const Center(child: Text('Hello, World!')),
      ),
    );
  }
}

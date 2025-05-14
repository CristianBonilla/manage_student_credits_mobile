import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Créditos para estudiantes',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'teachers': (_) => TeachersScreen(),
        'students': (_) => StudentsScreen(),
        'subjects': (_) => SubjectsScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/screens/create_subject.dart';
import 'package:manage_student_credits_mobile/screens/screens.dart';
import 'package:manage_student_credits_mobile/services/student_service.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeacherService()),
        ChangeNotifierProvider(create: (_) => StudentService()),
        ChangeNotifierProvider(create: (_) => SubjectService()),
      ],
      child: const MainApp(),
    );
  }
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
        'home': (_) => const HomeScreen(),
        'teachers': (_) => const TeachersScreen(),
        'students': (_) => const StudentsScreen(),
        'subjects': (_) => const SubjectsScreen(),
        'create-subject': (_) => const CreateSubjectScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          shape: CircleBorder(),
          elevation: 0,
        ),
      ),
    );
  }
}

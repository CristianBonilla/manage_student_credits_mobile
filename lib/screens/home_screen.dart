import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro en línea', style: TextStyle(color: Colors.white)),
      ),
      body: Background(),
    );
  }
}

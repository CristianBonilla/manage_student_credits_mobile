import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectService = Provider.of<SubjectService>(context);
    subjectService.getSubjects();

    return ScreenContainer(title: 'Asignaturas');
  }
}

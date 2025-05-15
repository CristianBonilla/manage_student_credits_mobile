import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);

    return ScreenContainer(
      title: 'Profesores',
      child: FutureBuilder(
        future: teacherService.getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(
              child: Transform.scale(
                scale: 1,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error?.toString() ??
                    'A server error occurred, the teachers could not be obtained',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (context, index) => TeacherCard(teacher: snapshot.data![index]),
          );
        },
      ),
    );
  }
}

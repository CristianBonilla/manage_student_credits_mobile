import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectService = Provider.of<SubjectService>(context);

    return ScreenContainer(
      title: 'Asignaturas',
      child: FutureBuilder(
        future: subjectService.getSubjects(),
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
                    'A server error occurred, the subjects could not be obtained',
              ),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (context, index) => Text(snapshot.data![index].toJson()),
            separatorBuilder:
                (context, index) =>
                    const Divider(height: 30, color: Colors.transparent),
          );
        },
      ),
    );
  }
}

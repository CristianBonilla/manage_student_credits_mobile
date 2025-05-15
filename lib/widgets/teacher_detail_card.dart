import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_detail_response.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class TeacherDetailCard extends StatelessWidget {
  final List<TeacherDetailResponse> teacherDetails;

  const TeacherDetailCard({super.key, required this.teacherDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: teacherDetails.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: Colors.white,
            width: MediaQuery.of(context).size.width - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextDetail(
                  title: 'Asignatura',
                  text: teacherDetails[index].subject.name,
                  size: 22,
                  color: Colors.black,
                ),
                TextDetail(
                  title: 'Créditos',
                  text: '${teacherDetails[index].credits}',
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_detail_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_detail_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class StudentDetailCard extends StatelessWidget {
  final List<(StudentDetailResponse, TeacherResponse)> studentDetails;

  const StudentDetailCard({super.key, required this.studentDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: studentDetails.length,
        itemBuilder: (context, index) {
          var (studentDetail, teacher) = studentDetails[index];
          final TeacherDetailResponse teacherDetail =
              studentDetail.teacherDetail;

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
                  title: 'Profesor',
                  text: '${teacher.firstname} ${teacher.lastname}',
                  color: Colors.black,
                  size: 22,
                ),
                TextDetail(
                  title: 'Asignatura',
                  text: teacherDetail.subject.name,
                  color: Colors.black,
                ),
                TextDetail(
                  title: 'Créditos',
                  text: '${teacherDetail.credits}',
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

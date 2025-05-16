import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_result.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class TeacherCard extends StatelessWidget {
  final TeacherResult teacher;

  const TeacherCard({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: _cardDecoration(),
            child: _container(),
          ),
        ),
        teacher.teacherDetails.isNotEmpty
            ? TeacherDetailCard(teacherDetails: teacher.teacherDetails)
            : SizedBox(),
      ],
    );
  }

  Widget _container() {
    final TeacherResponse info = teacher.teacher;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${info.firstname} ${info.lastname}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextDetail(title: 'Número de documento', text: info.documentNumber),
        TextDetail(title: 'Profesión', text: info.profession),
        TextDetail(title: 'Email', text: info.email),
      ],
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(15),
  );
}

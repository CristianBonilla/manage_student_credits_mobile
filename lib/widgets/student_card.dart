import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_result_detail.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class StudentCard extends StatelessWidget {
  final StudentResultDetail student;

  const StudentCard({super.key, required this.student});

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
        StudentDetailCard(studentDetails: student.studentDetails),
      ],
    );
  }

  Widget _container() {
    final StudentResponse info = student.student;

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
        TextDetail(title: 'Email', text: info.email),
      ],
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(15),
  );
}

import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_result_detail.dart';
import 'package:manage_student_credits_mobile/screens/enrollment_screen.dart';
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
          child:
              !student.canAddSubjects
                  ? _container()
                  : InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => EnrollmentScreen(student: student.student),
                        ),
                      );
                    },
                    child: _container(),
                  ),
        ),
        student.studentDetails.isNotEmpty
            ? StudentDetailCard(studentDetails: student.studentDetails)
            : SizedBox(),
      ],
    );
  }

  Container _container() {
    final StudentResponse info = student.student;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      decoration: _cardDecoration(),
      child: Column(
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
          TextDetail(
            title: 'Total de créditos',
            text: student.totalCredits.toString(),
            size: 20,
          ),
          !student.canAddSubjects
              ? Text(
                'No tiene permitido agregar más asignaturas',
                style: TextStyle(color: Colors.white),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: student.canAddSubjects ? Colors.green : Colors.grey,
    borderRadius: BorderRadius.circular(15),
  );
}

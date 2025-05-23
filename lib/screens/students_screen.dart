import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_result_detail.dart';
import 'package:manage_student_credits_mobile/services/student_service.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);
    final studentService = Provider.of<StudentService>(context);

    return ScreenContainer(
      title: 'Estudiantes',
      floatingActionOnPressed: () {
        Navigator.pushNamed(context, 'create-student');
      },
      child: FutureBuilder(
        future: _getStudentResultDetails(studentService, teacherService),
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
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  snapshot.error?.toString() ??
                      'A server error occurred, the students could not be obtained',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:
                (context, index) => StudentCard(student: snapshot.data![index]),
          );
        },
      ),
    );
  }

  Future<List<StudentResultDetail>> _getStudentResultDetails(
    StudentService studentService,
    TeacherService teacherService,
  ) async {
    List<StudentResultDetail> students =
        await Stream.fromFuture(studentService.getStudents())
            .asyncExpand(
              (students) =>
                  Stream.fromIterable(students).asyncMap((student) async {
                    final studentDetails =
                        await Stream.fromIterable(
                          student.studentDetails,
                        ).asyncMap((studentDetail) async {
                          final teacher = await teacherService.fetchTeacherById(
                            studentDetail.teacherDetail.teacherId,
                          );

                          return (studentDetail, teacher.teacher);
                        }).toList();
                    final totalCredits = await studentService
                        .fetchTotalCreditsById(student.student.studentId);
                    final canAddSubjects = await studentService.canAddSubjects(
                      student.student.studentId,
                    );

                    return StudentResultDetail(
                      student: student.student,
                      studentDetails: studentDetails,
                      totalCredits: totalCredits,
                      canAddSubjects: canAddSubjects,
                    );
                  }),
            )
            .toList();

    return students;
  }
}

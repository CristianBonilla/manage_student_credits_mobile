import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_result.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EnrollmentScreen extends StatefulWidget {
  final StudentResponse student;

  const EnrollmentScreen({super.key, required this.student});

  @override
  EnrollmentScreenState createState() => EnrollmentScreenState();
}

class EnrollmentScreenState extends State<EnrollmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _subjectIdSelected;
  String? _teacherIdSelected;

  @override
  Widget build(BuildContext context) {
    final subjectService = Provider.of<SubjectService>(context);
    final teacherService = Provider.of<TeacherService>(context);

    return ScreenContainer(
      title: 'Enrolamiento',
      hasFloatingButton: false,
      child: FormCard(
        formKey: _formKey,
        buttonText: 'Enrolar',
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              '${widget.student.firstname} ${widget.student.lastname}',
              style: TextStyle(fontSize: 22),
            ),
          ),
          SizedBox(height: 20),
          _subjectDropdownList(subjectService),
          SizedBox(height: 20),
          _subjectIdSelected == null
              ? SizedBox()
              : _teacherDropdownList(teacherService),
        ],
      ),
    );
  }

  FutureBuilder<List<SubjectResponse>> _subjectDropdownList(
    SubjectService subjectService,
  ) {
    return FutureBuilder(
      future: _getSubjects(subjectService),
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
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        }

        return DropdownButtonFormField(
          decoration: FieldDecorations.inputFormDecoration(
            labelText: 'Seleccionar asignatura',
          ),
          value: _subjectIdSelected,
          items:
              snapshot.requireData
                  .map(
                    (subject) => DropdownMenuItem(
                      value: subject.subjectId,
                      child: Text(subject.name),
                    ),
                  )
                  .toList(),
          onChanged: (subjectId) {
            setState(() {
              _subjectIdSelected = subjectId;
            });
          },
        );
      },
    );
  }

  FutureBuilder<List<TeacherResult>> _teacherDropdownList(
    TeacherService teacherService,
  ) {
    return FutureBuilder(
      future: _getTeachers(teacherService),
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

        return DropdownButtonFormField(
          decoration: FieldDecorations.inputFormDecoration(
            labelText: 'Seleccionar profesor',
          ),
          value: _teacherIdSelected,
          items:
              snapshot.requireData
                  .map(
                    (teacher) => DropdownMenuItem(
                      value: teacher.teacher.teacherId,
                      child: Text(
                        '${teacher.teacher.firstname} ${teacher.teacher.lastname}',
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (teacherId) {
            setState(() {
              _teacherIdSelected = teacherId;
            });
          },
        );
      },
    );
  }

  Future<List<SubjectResponse>> _getSubjects(
    SubjectService subjectService,
  ) async {
    final subjects = await subjectService.getSubjects();
    if (subjects.isNotEmpty && _subjectIdSelected == null) {
      setState(() {
        _subjectIdSelected = subjects[0].subjectId;
      });
    }

    return subjects;
  }

  Future<List<TeacherResult>> _getTeachers(
    TeacherService teacherService,
  ) async {
    final teachers = await teacherService.getTeachers();
    if (teachers.isNotEmpty && _teacherIdSelected == null) {
      setState(() {
        _teacherIdSelected = teachers[0].teacher.teacherId;
      });
    }

    return teachers;
  }
}

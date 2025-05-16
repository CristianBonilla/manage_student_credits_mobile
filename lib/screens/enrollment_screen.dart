import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';
import 'package:manage_student_credits_mobile/services/student_service.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EnrollmentScreen extends StatefulWidget {
  final StudentResponse student;

  const EnrollmentScreen({super.key, required this.student});

  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  String? _subjectIdSelected;
  String? _teacherIdSelected;
  bool _canActiveButton = false;

  @override
  Widget build(BuildContext context) {
    final subjectService = Provider.of<SubjectService>(context);
    final studentService = Provider.of<StudentService>(context);

    return ScreenContainer(
      title: 'Enrolamiento',
      hasFloatingButton: false,
      child: FormCard(
        buttonText: 'Enrolar',
        buttonOnPressed:
            !_canActiveButton ? null : _enrollment(context, studentService),
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
              : _teacherDropdownList(subjectService),
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

        return snapshot.requireData.isEmpty
            ? SizedBox()
            : DropdownButtonFormField(
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
                  _teacherIdSelected = null;
                });
              },
            );
      },
    );
  }

  FutureBuilder<List<TeacherResponse>> _teacherDropdownList(
    SubjectService subjectService,
  ) {
    return FutureBuilder(
      future: _getTeachers(subjectService),
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

        return snapshot.requireData.isEmpty
            ? SizedBox()
            : DropdownButtonFormField(
              decoration: FieldDecorations.inputFormDecoration(
                labelText: 'Seleccionar profesor',
              ),
              value: _teacherIdSelected,
              items:
                  snapshot.requireData
                      .map(
                        (teacher) => DropdownMenuItem(
                          value: teacher.teacherId,
                          child: Text(
                            '${teacher.firstname} ${teacher.lastname}',
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
      _enableButton();
    }

    return subjects;
  }

  Future<List<TeacherResponse>> _getTeachers(
    SubjectService subjectService,
  ) async {
    final teachers = await subjectService.fetchTeachersBySubjectId(
      _subjectIdSelected!,
    );
    if (teachers.isEmpty) {
      setState(() {
        _teacherIdSelected = null;
      });
      _enableButton();
    }
    if (teachers.isNotEmpty && _teacherIdSelected == null) {
      setState(() {
        _teacherIdSelected = teachers[0].teacherId;
      });
      _enableButton();
    }

    return teachers;
  }

  _enableButton() {
    setState(() {
      _canActiveButton =
          _subjectIdSelected != null && _teacherIdSelected != null;
    });
  }

  _enrollment(BuildContext context, StudentService studentService) {
    return () async {
      setState(() {
        _canActiveButton = false;
      });
      try {
        await studentService.assignSubject(
          widget.student.studentId,
          _teacherIdSelected!,
          _subjectIdSelected!,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Se agregó un nuevo enrolamiento'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'students');
        }
      } on ServiceErrorException catch (exception) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(exception.error.errors[0]),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        setState(() {
          _canActiveButton = true;
        });
      }
    };
  }
}

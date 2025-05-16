import 'package:manage_student_credits_mobile/models/student/student_detail_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';

class StudentResultDetail {
  final StudentResponse student;
  final List<(StudentDetailResponse, TeacherResponse)> studentDetails;
  final bool canAddSubjects;
  final num totalCredits;

  StudentResultDetail({
    required this.student,
    required this.studentDetails,
    required this.canAddSubjects,
    this.totalCredits = 0,
  });
}

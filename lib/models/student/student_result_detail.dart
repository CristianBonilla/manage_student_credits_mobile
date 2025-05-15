import 'package:manage_student_credits_mobile/models/student/student_detail_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';

class StudentResultDetail {
  final StudentResponse student;
  final List<(StudentDetailResponse, TeacherResponse)> studentDetails;
  final num totalCredits;

  const StudentResultDetail(
    this.student,
    this.studentDetails, [
    this.totalCredits = 0,
  ]);
}

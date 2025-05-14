import 'dart:convert';
import 'package:manage_student_credits_mobile/models/student/student_detail_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';

class StudentResult {
  final StudentResponse student;
  final List<StudentDetailResponse> studentDetails;

  StudentResult({required this.student, required this.studentDetails});

  factory StudentResult.fromJson(String studentResult) =>
      StudentResult.fromMap(json.decode(studentResult));

  String toJson() => json.encode(toMap());

  factory StudentResult.fromMap(Map<String, dynamic> json) => StudentResult(
    student: StudentResponse.fromMap(json['student']),
    studentDetails: List<StudentDetailResponse>.from(
      json['studentDetails'].map(
        (studentDetail) => StudentDetailResponse.fromMap(studentDetail),
      ),
    ),
  );

  Map<String, dynamic> toMap() => {
    'student': student.toMap(),
    'studentDetails': List<dynamic>.from(
      studentDetails.map((studentDetail) => studentDetail.toMap()),
    ),
  };
}

import 'dart:convert';
import 'package:manage_student_credits_mobile/models/teacher/teacher_detail_response.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';

class TeacherResult {
  final TeacherResponse teacher;
  final List<TeacherDetailResponse> teacherDetails;

  TeacherResult({required this.teacher, required this.teacherDetails});

  factory TeacherResult.fromJson(String teacherResult) =>
      TeacherResult.fromMap(json.decode(teacherResult));

  String toJson() => json.encode(toMap());

  factory TeacherResult.fromMap(Map<String, dynamic> json) => TeacherResult(
    teacher: TeacherResponse.fromMap(json['teacher']),
    teacherDetails: List<TeacherDetailResponse>.from(
      json['teacherDetails'].map(
        (teacherDetail) => TeacherDetailResponse.fromMap(teacherDetail),
      ),
    ),
  );

  Map<String, dynamic> toMap() => {
    'teacher': teacher.toMap(),
    'teacherDetails': List<dynamic>.from(
      teacherDetails.map((teacherDetail) => teacherDetail.toMap()),
    ),
  };
}

import 'dart:convert';
import 'package:manage_student_credits_mobile/models/teacher/teacher_detail_response.dart';

class StudentDetailResponse {
  final String studentId;
  final TeacherDetailResponse teacherDetail;
  final DateTime created;

  StudentDetailResponse({
    required this.studentId,
    required this.teacherDetail,
    required this.created,
  });

  factory StudentDetailResponse.fromJson(String studentDetail) =>
      StudentDetailResponse.fromMap(json.decode(studentDetail));

  String toJson() => json.encode(toMap());

  factory StudentDetailResponse.fromMap(Map<String, dynamic> json) =>
      StudentDetailResponse(
        studentId: json['studentId'],
        teacherDetail: TeacherDetailResponse.fromMap(json['teacherDetail']),
        created: DateTime.parse(json['created']),
      );

  Map<String, dynamic> toMap() => {
    'studentId': studentId,
    'teacherDetail': teacherDetail.toMap(),
    'created': created.toIso8601String(),
  };
}

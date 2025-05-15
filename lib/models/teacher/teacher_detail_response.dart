import 'dart:convert';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';

class TeacherDetailResponse {
  final String teacherId;
  final SubjectResponse subject;
  final num credits;
  final DateTime created;

  TeacherDetailResponse({
    required this.teacherId,
    required this.subject,
    required this.credits,
    required this.created,
  });

  factory TeacherDetailResponse.fromJson(String teacherDetail) =>
      TeacherDetailResponse.fromMap(json.decode(teacherDetail));

  String toJson() => json.encode(toMap());

  factory TeacherDetailResponse.fromMap(Map<String, dynamic> json) =>
      TeacherDetailResponse(
        teacherId: json['teacherId'],
        subject: SubjectResponse.fromMap(json['subject']),
        credits: json['credits'],
        created: DateTime.parse(json['created']),
      );

  Map<String, dynamic> toMap() => {
    'teacherId': teacherId,
    'subject': subject.toMap(),
    'credits': credits,
    'created': created.toIso8601String(),
  };
}

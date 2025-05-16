import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/constants/api.dart' as api;
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_request.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';
import 'package:http/http.dart' as http;
import 'package:manage_student_credits_mobile/models/teacher/teacher_response.dart';

class SubjectService extends ChangeNotifier {
  Future<List<SubjectResponse>> getSubjects() async {
    final Uri url = Uri.http(api.ApiUrl.baseUrl, api.ApiUrl.subjectUrl);
    final http.Response response = await http.get(url, headers: api.headers);
    final List<dynamic> subjectsDecode = json.decode(response.body);
    List<SubjectResponse> subjects =
        subjectsDecode
            .map((subject) => SubjectResponse.fromMap(subject))
            .toList();

    return subjects;
  }

  Future<SubjectResponse> addSubject(SubjectRequest subjectRequest) async {
    final Uri url = Uri.http(api.ApiUrl.baseUrl, api.ApiUrl.subjectUrl);
    final http.Response response = await http.post(
      url,
      headers: api.headers,
      body: subjectRequest.toJson(),
    );
    final dynamic responseDecode = json.decode(response.body);
    if (response.statusCode == 201) {
      SubjectResponse subject = SubjectResponse.fromMap(responseDecode);

      return subject;
    } else {
      throw ServiceErrorException(ServiceError.fromMap(responseDecode));
    }
  }

  Future<List<TeacherResponse>> fetchTeachersBySubjectId(
    String subjectId,
  ) async {
    final Uri url = Uri.http(
      api.ApiUrl.baseUrl,
      '${api.ApiUrl.subjectUrl}/$subjectId/teachers',
    );
    final http.Response response = await http.get(url, headers: api.headers);
    final List<dynamic> teachersDecode = json.decode(response.body);
    List<TeacherResponse> teachers =
        teachersDecode
            .map((teacher) => TeacherResponse.fromMap(teacher))
            .toList();

    return teachers;
  }
}

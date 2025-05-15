import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/constants/api.dart' as api;
import 'package:manage_student_credits_mobile/models/teacher/teacher_result.dart';
import 'package:http/http.dart' as http;

class TeacherService extends ChangeNotifier {
  Future<List<TeacherResult>> getTeachers() async {
    final Uri url = Uri.http(api.ApiUrl.baseUrl, api.ApiUrl.teacherUrl);
    late http.Response response;
    await _load(
      () async => response = await http.get(url, headers: api.headers),
    );
    final List<dynamic> teachersDecode = json.decode(response.body);
    List<TeacherResult> teachers =
        teachersDecode
            .map((teacher) => TeacherResult.fromMap(teacher))
            .toList();

    return teachers;
  }

  Future<TeacherResult> fetchTeacherById(String teacherId) async {
    final Uri url = Uri.http(
      api.ApiUrl.baseUrl,
      '${api.ApiUrl.teacherUrl}/$teacherId',
    );
    final http.Response response = await http.get(url, headers: api.headers);
    final dynamic teacherDecode = json.decode(response.body);
    final TeacherResult teacher = TeacherResult.fromMap(teacherDecode);

    return teacher;
  }

  Future _load<T>(Future<T> Function() asyncFunc) async {
    await Future.wait([asyncFunc(), Future.delayed(Duration(seconds: 3))]);
  }
}

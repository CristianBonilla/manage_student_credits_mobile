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
            .map((subject) => TeacherResult.fromMap(subject))
            .toList();

    return teachers;
  }

  Future _load<T>(Future<T> Function() asyncFunc) async {
    await Future.wait([asyncFunc(), Future.delayed(Duration(seconds: 3))]);
  }
}

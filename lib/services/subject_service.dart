import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/constants/app_url.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';
import 'package:http/http.dart' as http;

class SubjectService extends ChangeNotifier {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final List<SubjectResponse> subjects = [];

  Future<List<SubjectResponse>> getSubjects() async {
    final Uri url = Uri.http(AppUrl.baseUrl, AppUrl.subjectUrl);
    late http.Response response;
    await _load(() async => response = await http.get(url, headers: _headers));
    final List<dynamic> subjectsDecode = json.decode(response.body);
    List<SubjectResponse> subjects =
        subjectsDecode
            .map((subject) => SubjectResponse.fromMap(subject))
            .toList();

    return subjects;
  }

  Future _load<T>(Future<T> Function() asyncFunc) async {
    await Future.wait([asyncFunc(), Future.delayed(Duration(seconds: 3))]);
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/constants/api.dart' as api;
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/models/student/student_detail_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_request.dart';
import 'package:manage_student_credits_mobile/models/student/student_response.dart';
import 'package:manage_student_credits_mobile/models/student/student_result.dart';
import 'package:http/http.dart' as http;

class StudentService extends ChangeNotifier {
  Future<List<StudentResult>> getStudents() async {
    final Uri url = Uri.http(api.ApiUrl.baseUrl, api.ApiUrl.studentUrl);
    late http.Response response;
    await _load(
      () async => response = await http.get(url, headers: api.headers),
    );
    final List<dynamic> studentsDecode = json.decode(response.body);
    List<StudentResult> students =
        studentsDecode
            .map((student) => StudentResult.fromMap(student))
            .toList();

    return students;
  }

  Future<num> fetchTotalCreditsById(String studentId) async {
    final Uri url = Uri.http(
      api.ApiUrl.baseUrl,
      '${api.ApiUrl.studentUrl}/$studentId/total-credits',
    );
    final http.Response response = await http.get(url, headers: api.headers);
    num totalCredits = num.parse(response.body);

    return totalCredits;
  }

  Future<StudentResponse> addStudent(StudentRequest studentRequest) async {
    final Uri url = Uri.http(api.ApiUrl.baseUrl, api.ApiUrl.studentUrl);
    late http.Response response;
    await _load(
      () async =>
          response = await http.post(
            url,
            headers: api.headers,
            body: studentRequest.toJson(),
          ),
    );
    final dynamic responseDecode = json.decode(response.body);
    if (response.statusCode == 201) {
      StudentResponse student = StudentResponse.fromMap(responseDecode);

      return student;
    } else {
      throw ServiceErrorException(ServiceError.fromMap(responseDecode));
    }
  }

  Future<StudentDetailResponse> assignSubject(
    String studentId,
    String teacherId,
    String subjectId,
  ) async {
    final Uri url = Uri.http(
      api.ApiUrl.baseUrl,
      '${api.ApiUrl.studentUrl}/$studentId',
      {'teacherId': teacherId, 'subjectId': subjectId},
    );
    late http.Response response;
    await _load(
      () async => response = await http.post(url, headers: api.headers),
    );
    final dynamic responseDecode = json.decode(response.body);
    if (response.statusCode == 201) {
      StudentDetailResponse studentDetail = StudentDetailResponse.fromMap(
        responseDecode,
      );

      return studentDetail;
    } else {
      throw ServiceErrorException(ServiceError.fromMap(responseDecode));
    }
  }

  Future _load<T>(Future<T> Function() asyncFunc) async {
    await Future.wait([asyncFunc(), Future.delayed(Duration(seconds: 3))]);
  }
}

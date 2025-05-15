import 'dart:convert';

class TeacherRequest {
  String documentNumber = '';
  String firstname = '';
  String lastname = '';
  String email = '';
  String profession = '';

  TeacherRequest();

  factory TeacherRequest.fromJson(String teacher) =>
      TeacherRequest.fromMap(json.decode(teacher));

  String toJson() => json.encode(toMap());

  factory TeacherRequest.fromMap(Map<String, dynamic> json) {
    final teacher = TeacherRequest();
    teacher.documentNumber = json['documentNumber'];
    teacher.firstname = json['firstname'];
    teacher.lastname = json['lastname'];
    teacher.email = json['email'];
    teacher.profession = json['profession'];

    return teacher;
  }

  Map<String, dynamic> toMap() => {
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'profession': profession,
  };
}

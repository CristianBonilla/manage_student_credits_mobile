import 'dart:convert';

class TeacherResponse {
  final String teacherId;
  final String documentNumber;
  final String firstname;
  final String lastname;
  final String email;
  final String profession;
  final DateTime created;

  TeacherResponse({
    required this.teacherId,
    required this.documentNumber,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profession,
    required this.created,
  });

  factory TeacherResponse.fromJson(String teacher) =>
      TeacherResponse.fromMap(json.decode(teacher));

  String toJson() => json.encode(toMap());

  factory TeacherResponse.fromMap(Map<String, dynamic> json) => TeacherResponse(
    teacherId: json['teacherId'],
    documentNumber: json['documentNumber'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    profession: json['profession'],
    created: DateTime.parse(json['created']),
  );

  Map<String, dynamic> toMap() => {
    'teacherId': teacherId,
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'profession': profession,
    'created': created.toIso8601String(),
  };
}

import 'dart:convert';

class TeacherRequest {
  final String documentNumber;
  final String firstname;
  final String lastname;
  final String email;
  final String profession;

  TeacherRequest({
    required this.documentNumber,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profession,
  });

  factory TeacherRequest.fromJson(String teacher) =>
      TeacherRequest.fromMap(json.decode(teacher));

  String toJson() => json.encode(toMap());

  factory TeacherRequest.fromMap(Map<String, dynamic> json) => TeacherRequest(
    documentNumber: json['documentNumber'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    profession: json['profession'],
  );

  Map<String, dynamic> toMap() => {
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'profession': profession,
  };
}

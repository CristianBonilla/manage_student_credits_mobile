import 'dart:convert';

class StudentResponse {
  final String studentId;
  final String documentNumber;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime created;

  StudentResponse({
    required this.studentId,
    required this.documentNumber,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.created,
  });

  factory StudentResponse.fromJson(String student) =>
      StudentResponse.fromMap(json.decode(student));

  String toJson() => json.encode(toMap());

  factory StudentResponse.fromMap(Map<String, dynamic> json) => StudentResponse(
    studentId: json['studentId'],
    documentNumber: json['documentNumber'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    created: DateTime.parse(json['created']),
  );

  Map<String, dynamic> toMap() => {
    'studentId': studentId,
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'created': created.toIso8601String(),
  };
}

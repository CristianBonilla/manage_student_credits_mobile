import 'dart:convert';

class StudentRequest {
  final String documentNumber;
  final String firstname;
  final String lastname;
  final String email;

  StudentRequest({
    required this.documentNumber,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory StudentRequest.fromJson(String student) =>
      StudentRequest.fromMap(json.decode(student));

  String toJson() => json.encode(toMap());

  factory StudentRequest.fromMap(Map<String, dynamic> json) => StudentRequest(
    documentNumber: json['documentNumber'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
  );

  Map<String, dynamic> toMap() => {
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };
}

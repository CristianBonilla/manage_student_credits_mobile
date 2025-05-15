import 'dart:convert';

class StudentRequest {
  String documentNumber = '';
  String firstname = '';
  String lastname = '';
  String email = '';

  StudentRequest();

  factory StudentRequest.fromJson(String student) =>
      StudentRequest.fromMap(json.decode(student));

  String toJson() => json.encode(toMap());

  factory StudentRequest.fromMap(Map<String, dynamic> json) {
    final student = StudentRequest();
    student.documentNumber = json['documentNumber'];
    student.firstname = json['firstname'];
    student.lastname = json['lastname'];
    student.email = json['email'];

    return student;
  }

  Map<String, dynamic> toMap() => {
    'documentNumber': documentNumber,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };
}

import 'dart:convert';

class SubjectRequest {
  String name = '';
  String? description;

  SubjectRequest();

  factory SubjectRequest.fromJson(String subject) =>
      SubjectRequest.fromMap(json.decode(subject));

  String toJson() => json.encode(toMap());

  factory SubjectRequest.fromMap(Map<String, dynamic> json) {
    final subject = SubjectRequest();
    subject.name = json['name'];
    subject.description = json['description'];

    return subject;
  }

  Map<String, dynamic> toMap() => {'name': name, 'description': description};
}

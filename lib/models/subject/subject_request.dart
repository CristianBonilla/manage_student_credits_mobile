import 'dart:convert';

class SubjectRequest {
  final String name;
  final String? description;

  SubjectRequest({required this.name, this.description});

  factory SubjectRequest.fromJson(String subject) =>
      SubjectRequest.fromMap(json.decode(subject));

  String toJson() => json.encode(toMap());

  factory SubjectRequest.fromMap(Map<String, dynamic> json) =>
      SubjectRequest(name: json['name'], description: json['description']);

  Map<String, dynamic> toMap() => {'name': name, 'description': description};
}

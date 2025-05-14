import 'dart:convert';

class SubjectResponse {
  final String subjectId;
  final String name;
  final String? description;
  final DateTime created;

  SubjectResponse({
    required this.subjectId,
    required this.name,
    this.description,
    required this.created,
  });

  factory SubjectResponse.fromJson(String str) =>
      SubjectResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubjectResponse.fromMap(Map<String, dynamic> json) => SubjectResponse(
    subjectId: json['subjectId'],
    name: json['name'],
    description: json['description'],
    created: DateTime.parse(json['created']),
  );

  Map<String, dynamic> toMap() => {
    'subjectId': subjectId,
    'name': name,
    'description': description,
    'created': created.toIso8601String(),
  };
}

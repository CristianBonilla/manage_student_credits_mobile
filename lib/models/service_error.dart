import 'dart:convert';

class ServiceError {
  final String status;
  final int statusCode;
  final List<String> errors;

  ServiceError({
    required this.status,
    required this.statusCode,
    required this.errors,
  });

  factory ServiceError.fromJson(String serviceError) =>
      ServiceError.fromMap(json.decode(serviceError));

  String toJson() => json.encode(toMap());

  factory ServiceError.fromMap(Map<String, dynamic> json) => ServiceError(
    status: json['status'],
    statusCode: json['statusCode'],
    errors: List.from(json['errors']),
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'statusCode': statusCode,
    'errors': errors,
  };
}

class ServiceErrorException implements Exception {
  final ServiceError error;

  ServiceErrorException(this.error);
}

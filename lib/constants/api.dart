final class ApiUrl {
  static const String _host = '10.0.2.2';
  static const String baseUrl = '$_host:22163';
  static const String _extendedUrl = '/api/v1';
  static final String teacherUrl = '$_extendedUrl/teacher';
  static final String studentUrl = '$_extendedUrl/student';
  static final String subjectUrl = '$_extendedUrl/subject';
}

final Map<String, String> headers = {'Content-Type': 'application/json'};

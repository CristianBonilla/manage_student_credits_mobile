import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/teacher/teacher_request.dart';

class TeacherFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> teacherFormKey = GlobalKey();
  final TeacherRequest teacherRequest = TeacherRequest();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool isValidForm() {
    return teacherFormKey.currentState?.validate() ?? false;
  }
}

import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/student/student_request.dart';

class StudentFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> studentFormKey = GlobalKey();
  final StudentRequest studentRequest = StudentRequest();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool isValidForm() {
    return studentFormKey.currentState?.validate() ?? false;
  }
}

import 'package:flutter/widgets.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_request.dart';

class SubjectFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> subjectFormKey = GlobalKey();
  final SubjectRequest subjectRequest = SubjectRequest();

  bool isValidForm() {
    return subjectFormKey.currentState?.validate() ?? false;
  }
}

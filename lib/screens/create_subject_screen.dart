import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/providers/subject_form_provider.dart';
import 'package:manage_student_credits_mobile/services/subject_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
import 'package:manage_student_credits_mobile/utils/form_utils.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CreateSubjectScreen extends StatelessWidget {
  const CreateSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: 'Crear asignatura',
      hasFloatingButton: false,
      child: ChangeNotifierProvider(
        create: (_) => SubjectFormProvider(),
        child: _SubjectForm(),
      ),
    );
  }
}

class _SubjectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subjectService = Provider.of<SubjectService>(context);
    final subjectFormProvider = Provider.of<SubjectFormProvider>(context);
    final subjectRequest = subjectFormProvider.subjectRequest;

    return FormCard(
      formKey: subjectFormProvider.subjectFormKey,
      buttonText:
          subjectFormProvider.isLoading ? 'Cargando...' : 'Guardar Asignatura',
      buttonOnPressed:
          subjectFormProvider.isLoading
              ? null
              : _addSubject(context, subjectService, subjectFormProvider),
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Clean Architectures',
            labelText: 'Nombre de la asignatura',
            icon: Icons.subject,
          ),
          onChanged: (name) => subjectRequest.name = name,
          validator: SubjectValidators.nameValidator(),
        ),
        SizedBox(height: 20),
        TextFormField(
          maxLines: 3,
          autocorrect: false,
          keyboardType: TextInputType.multiline,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Detalles...',
            labelText: 'Descripción de la asignatura',
            icon: Icons.description,
          ),
          onChanged: (description) => subjectRequest.description = description,
          validator: SubjectValidators.descriptionValidator(),
        ),
      ],
    );
  }

  void Function() _addSubject(
    BuildContext context,
    SubjectService subjectService,
    SubjectFormProvider subjectFormProvider,
  ) {
    return () async {
      FocusScope.of(context).unfocus();
      if (subjectFormProvider.isValidForm()) {
        subjectFormProvider.isLoading = true;
        try {
          await subjectService.addSubject(subjectFormProvider.subjectRequest);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Se agregó una nueva asignatura'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'subjects');
          }
        } on ServiceErrorException catch (exception) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.error.errors[0]),
                backgroundColor: Colors.red,
              ),
            );
          }
        } finally {
          subjectFormProvider.isLoading = false;
        }
      }
    };
  }
}

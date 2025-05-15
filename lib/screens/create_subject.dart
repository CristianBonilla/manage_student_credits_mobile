import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/providers/subject_form_provider.dart';
import 'package:manage_student_credits_mobile/ui/input_decorations.dart';
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
    final subjectFormProvider = Provider.of<SubjectFormProvider>(context);
    final subjectRequest = subjectFormProvider.subjectRequest;

    return FormCard(
      formKey: subjectFormProvider.subjectFormKey,
      buttonText: 'Guardar Asignatura',
      buttonOnPressed: () {
        if (subjectFormProvider.isValidForm()) {
          Navigator.pushReplacementNamed(context, 'subjects');
        }
      },
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Clean Architectures',
            labelText: 'Nombre de la asignatura',
            icon: Icons.subject,
          ),
          onChanged: (name) => subjectRequest.name = name,
          validator: (name) {
            if (name == null || name.trim().isEmpty) {
              return 'El nombre es requerido';
            }

            final RegExp minExpr = RegExp(r'^.{3,}$');
            if (!minExpr.hasMatch(name.trim())) {
              return 'El nombre debe tener mínimo 3 carácteres';
            }

            final RegExp maxExpr = RegExp(r'^.{1,30}$');
            if (!maxExpr.hasMatch(name.trim())) {
              return 'El nombre debe tener máximo 30 carácteres';
            }

            final RegExp patternExpr = RegExp(r'^[a-zA-Z0-9 ]+$');
            if (!patternExpr.hasMatch(name.trim())) {
              return 'El nombre solo debe tener letras, números y espacios';
            }

            return null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          maxLines: 3,
          autocorrect: false,
          keyboardType: TextInputType.multiline,
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Detalles...',
            labelText: 'Descripción de la asignatura',
            icon: Icons.description,
          ),
          onChanged: (description) => subjectRequest.description = description,
          validator: (description) {
            final RegExp minExpr = RegExp(r'^.{5,}$');
            if (description != null &&
                description.trim().isNotEmpty &&
                !minExpr.hasMatch(description.trim())) {
              return 'La descripción debe tener al menos 5 carácteres';
            }

            return null;
          },
        ),
      ],
    );
  }
}

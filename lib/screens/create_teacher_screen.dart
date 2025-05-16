import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/providers/teacher_form_provider.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
import 'package:manage_student_credits_mobile/utils/form_utils.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CreateTeacherScreen extends StatelessWidget {
  const CreateTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: 'Crear Profesor',
      hasFloatingButton: false,
      child: ChangeNotifierProvider(
        create: (_) => TeacherFormProvider(),
        child: _TeacherForm(),
      ),
    );
  }
}

class _TeacherForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teacherService = Provider.of<TeacherService>(context);
    final teacherFormProvider = Provider.of<TeacherFormProvider>(context);
    final teacherRequest = teacherFormProvider.teacherRequest;

    return FormCard(
      formKey: teacherFormProvider.teacherFormKey,
      buttonText:
          teacherFormProvider.isLoading ? 'Cargando...' : 'Guardar Profesor',
      buttonOnPressed:
          teacherFormProvider.isLoading
              ? null
              : _addTeacher(context, teacherService, teacherFormProvider),
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.number,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Número de documento',
            labelText: 'Número de documento',
            icon: Icons.badge,
          ),
          onChanged:
              (documentNumber) =>
                  teacherRequest.documentNumber = documentNumber,
          validator: CommonValidators.documentNumberValidator(
            'número de documento',
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Nombres',
            labelText: 'Nombres',
            icon: Icons.account_box,
          ),
          onChanged: (firstname) => teacherRequest.firstname = firstname,
          validator: CommonValidators.namesValidator('nombres'),
        ),
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Apellidos',
            labelText: 'Apellidos',
            icon: Icons.account_box,
          ),
          onChanged: (lastname) => teacherRequest.lastname = lastname,
          validator: CommonValidators.namesValidator('apellidos'),
        ),
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'cristian.bonilla@gmail.com',
            labelText: 'Email',
            icon: Icons.email,
          ),
          onChanged: (email) => teacherRequest.email = email,
          validator: CommonValidators.emailValidator(),
        ),
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'Software Enginner',
            labelText: 'Profesión',
            icon: Icons.check_circle,
          ),
          onChanged: (profession) => teacherRequest.profession = profession,
          validator: CommonValidators.professionValidator(),
        ),
      ],
    );
  }

  void Function() _addTeacher(
    BuildContext context,
    TeacherService teacherService,
    TeacherFormProvider teacherFormProvider,
  ) {
    return () async {
      FocusScope.of(context).unfocus();
      if (teacherFormProvider.isValidForm()) {
        teacherFormProvider.isLoading = true;
        try {
          await teacherService.addTeacher(teacherFormProvider.teacherRequest);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Se agregó un nuevo profesor'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'teachers');
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
          teacherFormProvider.isLoading = false;
        }
      }
    };
  }
}

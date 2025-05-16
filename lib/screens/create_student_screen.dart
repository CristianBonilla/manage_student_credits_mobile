import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/providers/student_form_provider.dart';
import 'package:manage_student_credits_mobile/services/student_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
import 'package:manage_student_credits_mobile/utils/form_utils.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CreateStudentScreen extends StatelessWidget {
  const CreateStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: 'Crear Estudiante',
      hasFloatingButton: false,
      child: ChangeNotifierProvider(
        create: (_) => StudentFormProvider(),
        child: _StudentForm(),
      ),
    );
  }
}

class _StudentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentService = Provider.of<StudentService>(context);
    final studentFormProvider = Provider.of<StudentFormProvider>(context);
    final studentRequest = studentFormProvider.studentRequest;

    return FormCard(
      formKey: studentFormProvider.studentFormKey,
      buttonText:
          studentFormProvider.isLoading ? 'Cargando...' : 'Guardar Estudiante',
      buttonOnPressed:
          studentFormProvider.isLoading
              ? null
              : _addStudent(context, studentService, studentFormProvider),
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
                  studentRequest.documentNumber = documentNumber,
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
          onChanged: (firstname) => studentRequest.firstname = firstname,
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
          onChanged: (lastname) => studentRequest.lastname = lastname,
          validator: CommonValidators.namesValidator('apellidos'),
        ),
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: FieldDecorations.inputFormDecoration(
            hinText: 'john.duarte@gmail.com',
            labelText: 'Email',
            icon: Icons.email,
          ),
          onChanged: (email) => studentRequest.email = email,
          validator: CommonValidators.emailValidator(),
        ),
      ],
    );
  }

  void Function() _addStudent(
    BuildContext context,
    StudentService studentService,
    StudentFormProvider studentFormProvider,
  ) {
    return () async {
      FocusScope.of(context).unfocus();
      if (studentFormProvider.isValidForm()) {
        studentFormProvider.isLoading = true;
        try {
          await studentService.addStudent(studentFormProvider.studentRequest);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Se agregó un nuevo estudiante'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, 'students');
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
          studentFormProvider.isLoading = false;
        }
      }
    };
  }
}

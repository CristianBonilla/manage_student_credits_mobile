import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/providers/student_form_provider.dart';
import 'package:manage_student_credits_mobile/services/student_service.dart';
import 'package:manage_student_credits_mobile/ui/field_decorations.dart';
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
          validator: (documentNumber) {
            if (documentNumber == null || documentNumber.trim().isEmpty) {
              return 'El número de documento es requerido';
            }

            final RegExp numericExpr = RegExp(r'^\d+$');
            if (!numericExpr.hasMatch(documentNumber.trim())) {
              return 'El número de documento solo debe tener valores numéricos';
            }

            final RegExp minExpr = RegExp(r'^.{3,}$');
            if (!minExpr.hasMatch(documentNumber.trim())) {
              return 'El número de documento debe tener mínimo 3 carácteres';
            }

            final RegExp maxExpr = RegExp(r'^.{1,10}$');
            if (!maxExpr.hasMatch(documentNumber.trim())) {
              return 'El número de documento debe tener máximo 10 carácteres';
            }

            return null;
          },
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
          validator: (firstname) {
            if (firstname == null || firstname.trim().isEmpty) {
              return 'Los nombres son requeridos';
            }

            final RegExp nameExpr = RegExp(r'^[a-zA-Z ]+$');
            if (!nameExpr.hasMatch(firstname.trim())) {
              return 'Los nombres solo debe tener letras y espacios';
            }

            final RegExp minExpr = RegExp(r'^.{3,}$');
            if (!minExpr.hasMatch(firstname.trim())) {
              return 'Los nombres debe tener mínimo 3 carácteres';
            }

            final RegExp maxExpr = RegExp(r'^.{1,50}$');
            if (!maxExpr.hasMatch(firstname.trim())) {
              return 'Los nombres debe tener máximo 50 carácteres';
            }

            return null;
          },
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
          validator: (firstname) {
            if (firstname == null || firstname.trim().isEmpty) {
              return 'Los apellidos son requeridos';
            }

            final RegExp nameExpr = RegExp(r'^[a-zA-Z ]+$');
            if (!nameExpr.hasMatch(firstname.trim())) {
              return 'Los apellidos solo debe tener letras y espacios';
            }

            final RegExp minExpr = RegExp(r'^.{3,}$');
            if (!minExpr.hasMatch(firstname.trim())) {
              return 'Los apellidos debe tener mínimo 3 carácteres';
            }

            final RegExp maxExpr = RegExp(r'^.{1,50}$');
            if (!maxExpr.hasMatch(firstname.trim())) {
              return 'Los apellidos debe tener máximo 50 carácteres';
            }

            return null;
          },
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
          validator: (email) {
            if (email == null || email.trim().isEmpty) {
              return 'El correo es requerido';
            }

            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            final RegExp emailExpr = RegExp(pattern);
            if (!emailExpr.hasMatch(email.trim())) {
              return 'El correo no es válido';
            }

            final RegExp maxExpr = RegExp(r'^.{1,100}$');
            if (!maxExpr.hasMatch(email.trim())) {
              return 'El correo debe tener máximo 100 carácteres';
            }

            return null;
          },
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

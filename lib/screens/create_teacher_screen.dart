import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/service_error.dart';
import 'package:manage_student_credits_mobile/providers/teacher_form_provider.dart';
import 'package:manage_student_credits_mobile/services/teacher_service.dart';
import 'package:manage_student_credits_mobile/ui/input_decorations.dart';
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
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Número de documento',
            labelText: 'Número de documento',
            icon: Icons.badge,
          ),
          onChanged:
              (documentNumber) =>
                  teacherRequest.documentNumber = documentNumber,
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
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Nombres',
            labelText: 'Nombres',
            icon: Icons.account_box,
          ),
          onChanged: (firstname) => teacherRequest.firstname = firstname,
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
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Apellidos',
            labelText: 'Apellidos',
            icon: Icons.account_box,
          ),
          onChanged: (lastname) => teacherRequest.lastname = lastname,
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
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'cristian.bonilla@gmail.com',
            labelText: 'Email',
            icon: Icons.email,
          ),
          onChanged: (email) => teacherRequest.email = email,
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
        SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputDecorations.inputFormDecoration(
            hinText: 'Software Enginner',
            labelText: 'Profesión',
            icon: Icons.check_circle,
          ),
          onChanged: (profession) => teacherRequest.profession = profession,
          validator: (profession) {
            if (profession == null || profession.trim().isEmpty) {
              return 'La profesión es requerida';
            }

            final RegExp patternExpr = RegExp(r'^[a-zA-Z0-9 ]+$');
            if (!patternExpr.hasMatch(profession.trim())) {
              return 'La profesión solo debe tener letras, números y espacios';
            }

            final RegExp minExpr = RegExp(r'^.{2,}$');
            if (!minExpr.hasMatch(profession.trim())) {
              return 'La profesión debe tener mínimo 2 carácteres';
            }

            final RegExp maxExpr = RegExp(r'^.{1,30}$');
            if (!maxExpr.hasMatch(profession.trim())) {
              return 'La profesión debe tener máximo 30 carácteres';
            }

            return null;
          },
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

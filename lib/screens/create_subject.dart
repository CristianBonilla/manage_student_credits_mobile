import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class CreateSubjectScreen extends StatelessWidget {
  const CreateSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: 'Crear asignatura',
      hasFloatingButton: false,
      child: FormCard(
        buttonText: 'Guardar Asignatura',
        children: [
          InputFormDecoration(
            hinText: 'Clean Architectures',
            labelText: 'Nombre de la asignatura',
            icon: Icons.subject,
            inputType: TextInputType.name,
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
          InputFormDecoration(
            hinText: 'Detalles...',
            labelText: 'Descripción de la asignatura',
            icon: Icons.description,
            inputType: TextInputType.multiline,
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
      ),
    );
  }
}

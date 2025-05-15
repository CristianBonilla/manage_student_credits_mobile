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
          ),
          SizedBox(height: 20),
          InputFormDecoration(
            hinText: 'Detalles...',
            labelText: 'Descripción de la asignatura',
            icon: Icons.description,
            inputType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}

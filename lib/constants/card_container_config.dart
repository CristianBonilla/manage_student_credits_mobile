import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/card_container_info.dart';

List<CardContainerInfo> cardContainerConfig = <CardContainerInfo>[
  CardContainerInfo(
    text: 'Asignaturas',
    textIcon: Icons.subject,
    backgroundColor: Colors.redAccent,
  ),
  CardContainerInfo(
    text: 'Profesores',
    textIcon: Icons.group,
    backgroundColor: Colors.blueAccent,
  ),
  CardContainerInfo(
    text: 'Estudiantes',
    textIcon: Icons.groups,
    backgroundColor: Colors.green,
  ),
];

import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/card_container_info.dart';

final List<CardContainerInfo> cardContainerConfig = <CardContainerInfo>[
  CardContainerInfo(
    route: 'teachers',
    text: 'Profesores',
    textIcon: Icons.group,
    backgroundColor: Colors.blueAccent,
  ),
  CardContainerInfo(
    route: 'students',
    text: 'Estudiantes',
    textIcon: Icons.groups,
    backgroundColor: Colors.green,
  ),
  CardContainerInfo(
    route: 'subjects',
    text: 'Asignaturas',
    textIcon: Icons.subject,
    backgroundColor: Colors.redAccent,
  ),
];

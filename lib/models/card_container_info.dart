import 'package:flutter/material.dart';

class CardContainerInfo {
  final String route;
  final String text;
  final Color? textColor;
  final IconData? textIcon;
  final Color? backgroundColor;

  CardContainerInfo({
    required this.route,
    required this.text,
    this.textColor = Colors.white,
    this.textIcon,
    this.backgroundColor = Colors.white,
  });
}

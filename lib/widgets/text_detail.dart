import 'package:flutter/material.dart';

class TextDetail extends StatelessWidget {
  final String title;
  final String text;
  final double? size;
  final Color? color;

  const TextDetail({
    super.key,
    required this.title,
    required this.text,
    this.size = 17,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: TextStyle(fontSize: size),
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          WidgetSpan(child: SizedBox(width: 5)),
          TextSpan(text: text, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

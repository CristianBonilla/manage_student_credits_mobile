import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/subject/subject_response.dart';

class SubjectCard extends StatelessWidget {
  final SubjectResponse subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: double.infinity,
        decoration: _cardDecoration(),
        child: _container(),
      ),
    );
  }

  Widget _container() {
    final Text text = Text(
      subject.name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
    if (subject.description == null) {
      return text;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text,
        Text(subject.description!, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.redAccent,
    borderRadius: BorderRadius.circular(15),
  );
}

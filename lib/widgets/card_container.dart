import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/models/card_container_info.dart';

class CardContainer extends StatelessWidget {
  final CardContainerInfo info;

  const CardContainer({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 200,
        decoration: _createCardShape(),
        child: Center(child: _container()),
      ),
    );
  }

  Widget _container() {
    final Text text = Text(
      info.text,
      style: TextStyle(
        color: info.textColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );

    if (info.textIcon == null) {
      return text;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [Icon(info.textIcon, size: 40, color: info.textColor), text],
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: info.backgroundColor,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5)),
    ],
  );
}

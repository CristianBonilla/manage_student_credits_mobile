import 'package:flutter/material.dart';
import 'package:manage_student_credits_mobile/constants/card_container_config.dart';
import 'package:manage_student_credits_mobile/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro en línea',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Background(
        child: ListView.separated(
          itemCount: cardContainerConfig.length,
          itemBuilder:
              (context, index) =>
                  CardContainer(info: cardContainerConfig[index]),
          separatorBuilder:
              (context, index) =>
                  const Divider(height: 30, color: Colors.transparent),
        ),
      ),
    );
  }
}

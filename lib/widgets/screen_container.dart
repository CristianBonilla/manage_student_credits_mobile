import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final VoidCallback? floatingActionOnPressed;

  const ScreenContainer({
    super.key,
    required this.title,
    this.child,
    this.floatingActionOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(color: Colors.white))),
      body: child,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: floatingActionOnPressed,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

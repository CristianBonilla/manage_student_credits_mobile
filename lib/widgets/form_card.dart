import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final List<Widget> children;
  final String buttonText;
  final VoidCallback? buttonOnPressed;

  const FormCard({
    super.key,
    this.children = const [],
    required this.buttonText,
    this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: _cardDecoration(),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [...children, SizedBox(height: 40), _action()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5)),
    ],
  );

  MaterialButton _action() => MaterialButton(
    onPressed: buttonOnPressed ?? () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    disabledColor: Colors.grey,
    elevation: 0,
    color: Colors.deepPurple,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

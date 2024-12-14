import 'package:flutter/material.dart';

enum ButtonType { number, operator, function, equals }

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: _getButtonColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _getTextColor(),
        ),
      ),
    );
  }

  Color _getButtonColor() {
    switch (type) {
      case ButtonType.number:
        return Colors.white;
      case ButtonType.operator:
        return Colors.blue[100]!;
      case ButtonType.function:
        return Colors.grey[300]!;
      case ButtonType.equals:
        return Colors.blue;
    }
  }

  Color _getTextColor() {
    return type == ButtonType.equals ? Colors.white : Colors.black;
  }
}

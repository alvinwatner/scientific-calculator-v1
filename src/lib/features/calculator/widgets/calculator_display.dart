import 'package:flutter/material.dart';
import 'package:scientific_calc/ui/common/app_colors.dart';
import 'package:scientific_calc/ui/common/ui_helpers.dart';

class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final String status;

  const CalculatorDisplay({
    Key? key,
    required this.expression,
    required this.result,
    this.status = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: kcVeryLightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text(
              expression,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: kcMediumGrey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: status == 'Error' ? Colors.red : kcDarkGreyColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (status.isNotEmpty && status != 'Error')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerRight,
              child: Text(
                status,
                style: const TextStyle(
                  fontSize: 14,
                  color: kcMediumGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

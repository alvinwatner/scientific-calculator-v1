import 'package:flutter/material.dart';
import 'package:scientific_calc/features/calculator/models/calculation_result.dart';
import 'package:scientific_calc/ui/common/app_colors.dart';
import 'package:scientific_calc/ui/common/ui_helpers.dart';

class CalculationHistory extends StatelessWidget {
  final List<CalculationResult> history;
  final Function(CalculationResult) onHistoryItemTapped;

  const CalculationHistory({
    Key? key,
    required this.history,
    required this.onHistoryItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: history.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = history[index];
        return ListTile(
          onTap: () => onHistoryItemTapped(item),
          title: Text(
            item.expression,
            style: const TextStyle(
              fontSize: 16,
              color: kcMediumGrey,
            ),
          ),
          subtitle: Text(
            item.result,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kcDarkGreyColor,
            ),
          ),
          trailing: Text(
            item.timestamp.toString().split('.')[0],
            style: const TextStyle(
              fontSize: 12,
              color: kcLightGrey,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:scientific_calc/features/calculator/calculator_viewmodel.dart';
import 'package:scientific_calc/features/calculator/widgets/calculator_button.dart';
import 'package:scientific_calc/features/calculator/widgets/calculator_display.dart';

class CalculatorView extends StackedView<CalculatorViewModel> {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CalculatorViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CalculatorDisplay(
            expression: viewModel.expression,
            result: viewModel.result,
          ),
          const Divider(height: 1),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 4,
              childAspectRatio: 1.3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                CalculatorButton(
                  text: 'C',
                  onPressed: viewModel.clear,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  text: '(',
                  onPressed: () => viewModel.appendOperator('('),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: ')',
                  onPressed: () => viewModel.appendOperator(')'),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: '⌫',
                  onPressed: viewModel.delete,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  text: 'sin',
                  onPressed: () => viewModel.appendFunction('sin'),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  text: 'cos',
                  onPressed: () => viewModel.appendFunction('cos'),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  text: 'tan',
                  onPressed: () => viewModel.appendFunction('tan'),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  text: '÷',
                  onPressed: () => viewModel.appendOperator('/'),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: '7',
                  onPressed: () => viewModel.appendNumber('7'),
                ),
                CalculatorButton(
                  text: '8',
                  onPressed: () => viewModel.appendNumber('8'),
                ),
                CalculatorButton(
                  text: '9',
                  onPressed: () => viewModel.appendNumber('9'),
                ),
                CalculatorButton(
                  text: '×',
                  onPressed: () => viewModel.appendOperator('*'),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: '4',
                  onPressed: () => viewModel.appendNumber('4'),
                ),
                CalculatorButton(
                  text: '5',
                  onPressed: () => viewModel.appendNumber('5'),
                ),
                CalculatorButton(
                  text: '6',
                  onPressed: () => viewModel.appendNumber('6'),
                ),
                CalculatorButton(
                  text: '-',
                  onPressed: () => viewModel.appendOperator('-'),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: '1',
                  onPressed: () => viewModel.appendNumber('1'),
                ),
                CalculatorButton(
                  text: '2',
                  onPressed: () => viewModel.appendNumber('2'),
                ),
                CalculatorButton(
                  text: '3',
                  onPressed: () => viewModel.appendNumber('3'),
                ),
                CalculatorButton(
                  text: '+',
                  onPressed: () => viewModel.appendOperator('+'),
                  type: ButtonType.operator,
                ),
                CalculatorButton(
                  text: '0',
                  onPressed: () => viewModel.appendNumber('0'),
                ),
                CalculatorButton(
                  text: '.',
                  onPressed: () => viewModel.appendNumber('.'),
                ),
                CalculatorButton(
                  text: 'π',
                  onPressed: () => viewModel.appendNumber('π'),
                ),
                CalculatorButton(
                  text: '=',
                  onPressed: viewModel.calculate,
                  type: ButtonType.equals,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  CalculatorViewModel viewModelBuilder(BuildContext context) =>
      CalculatorViewModel();
}

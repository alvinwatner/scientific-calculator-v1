import 'package:stacked/stacked.dart';
import 'package:scientific_calc/features/calculator/calculator_service.dart';
import 'package:scientific_calc/app/app.locator.dart';

class CalculatorViewModel extends BaseViewModel {
  final _calculatorService = locator<CalculatorService>();

  String _expression = '';
  String _result = '';

  String get expression => _expression;
  String get result => _result;

  void appendNumber(String number) {
    _expression += number;
    notifyListeners();
  }

  void appendOperator(String operator) {
    _expression += operator;
    notifyListeners();
  }

  void appendFunction(String function) {
    _expression += '$function(';
    notifyListeners();
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _expression = '';
    _result = '';
    notifyListeners();
  }

  void calculate() {
    try {
      _result = _calculatorService.evaluate(_expression);
      notifyListeners();
    } catch (e) {
      _result = 'Error';
      notifyListeners();
    }
  }
}

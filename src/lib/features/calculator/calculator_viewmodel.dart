import 'package:stacked/stacked.dart';
import 'package:scientific_calc/features/calculator/calculator_service.dart';
import 'package:scientific_calc/features/calculator/models/calculation_result.dart';
import 'package:scientific_calc/features/calculator/models/calculator_error.dart';
import 'package:scientific_calc/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class CalculatorViewModel extends BaseViewModel {
  final _calculatorService = locator<CalculatorService>();
  final _dialogService = locator<DialogService>();

  String _expression = '';
  String _result = '';
  String _status = '';
  final List<CalculationResult> _history = [];

  String get expression => _expression;
  String get result => _result;
  String get status => _status;
  List<CalculationResult> get history => _history;

  void appendNumber(String number) {
    _expression += number;
    notifyListeners();
  }

  void appendOperator(String operator) {
    if (_expression.isEmpty && _result.isNotEmpty) {
      _expression = _result + operator;
    } else if (_expression.isNotEmpty) {
      _expression += operator;
    }
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
    _status = '';
    notifyListeners();
  }

  Future<void> calculate() async {
    if (_expression.isEmpty) return;

    try {
      _status = 'Computing...';
      notifyListeners();

      final result = await runBusyFuture(
        Future.delayed(
          const Duration(milliseconds: 100),
          () => _calculatorService.evaluate(_expression),
        ),
      );

      _result = result;
      _status = '';

      _history.insert(
        0,
        CalculationResult(
          expression: _expression,
          result: result,
          timestamp: DateTime.now(),
        ),
      );

      if (_history.length > 100) {
        _history.removeLast();
      }
    } on CalculatorError catch (e) {
      _result = 'Error';
      _status = e.message;
      await _dialogService.showDialog(
        title: 'Calculation Error',
        description: e.message,
        dialogPriority: DialogPriority.high,
      );
    } catch (e) {
      _result = 'Error';
      _status = 'An unexpected error occurred';
      await _dialogService.showDialog(
        title: 'Unexpected Error',
        description: 'Please check your input and try again.',
        dialogPriority: DialogPriority.high,
      );
    }
    notifyListeners();
  }

  void useHistoryItem(CalculationResult item) {
    _expression = item.result;
    _result = '';
    _status = '';
    notifyListeners();
  }
}

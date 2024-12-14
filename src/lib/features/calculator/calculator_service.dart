import 'dart:math' as math;
import 'package:scientific_calc/features/calculator/models/calculator_error.dart';

class CalculatorService {
  static const double _maxValue = 1e308;
  static const double _minValue = -1e308;
  static const double _epsilon = 1e-15;

  String evaluate(String expression) {
    try {
      if (expression.isEmpty) {
        throw CalculatorError(
          message: 'Empty expression',
          type: ErrorType.invalidExpression,
        );
      }

      // Replace π with its value
      expression = expression.replaceAll('\u03c0', math.pi.toString());

      // Handle basic arithmetic and scientific functions
      double result = _evaluateExpression(expression);

      // Validate result bounds
      if (result.isInfinite) {
        throw CalculatorError(
          message: 'Result too large',
          type: ErrorType.overflow,
        );
      }
      if (result != 0 && result.abs() < _epsilon) {
        throw CalculatorError(
          message: 'Result too small',
          type: ErrorType.underflow,
        );
      }

      // Format the result
      if (result.abs() >= 1e16 || (result != 0 && result.abs() < 1e-4)) {
        return result.toStringAsExponential(12);
      } else {
        String formatted = result
            .toStringAsFixed(12)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
        return formatted.isEmpty ? '0' : formatted;
      }
    } on CalculatorError {
      rethrow;
    } catch (e) {
      throw CalculatorError(
        message: 'Invalid expression',
        type: ErrorType.invalidExpression,
      );
    }
  }

  double _evaluateExpression(String expression) {
    expression = _handleScientificFunctions(expression);
    return _evaluateBasicExpression(expression);
  }

  String _handleScientificFunctions(String expression) {
    expression = _replaceTrigFunction(expression, 'sin');
    expression = _replaceTrigFunction(expression, 'cos');
    expression = _replaceTrigFunction(expression, 'tan');
    expression = _replaceLogFunction(expression);
    return expression;
  }

  String _replaceTrigFunction(String expression, String funcName) {
    RegExp regex = RegExp('$funcName\\((.*?)\\)');
    while (expression.contains(regex)) {
      Match match = regex.firstMatch(expression)!;
      String arg = match.group(1)!;
      double value = _evaluateBasicExpression(arg);

      double result;
      switch (funcName) {
        case 'sin':
          result = math.sin(value);
          break;
        case 'cos':
          result = math.cos(value);
          break;
        case 'tan':
          if (math.cos(value).abs() < _epsilon) {
            throw CalculatorError(
              message: 'Undefined tangent value',
              type: ErrorType.calculation,
            );
          }
          result = math.tan(value);
          break;
        default:
          throw CalculatorError(
            message: 'Unknown function: $funcName',
            type: ErrorType.invalidFunction,
          );
      }

      expression = expression.replaceFirst(regex, result.toString());
    }
    return expression;
  }

  String _replaceLogFunction(String expression) {
    RegExp regex = RegExp(r'log\((.*?)\)');
    while (expression.contains(regex)) {
      Match match = regex.firstMatch(expression)!;
      String arg = match.group(1)!;
      double value = _evaluateBasicExpression(arg);

      if (value <= 0) {
        throw CalculatorError(
          message: 'Invalid logarithm argument',
          type: ErrorType.calculation,
        );
      }

      double result = math.log(value);
      expression = expression.replaceFirst(regex, result.toString());
    }
    return expression;
  }

  double _evaluateBasicExpression(String expression) {
    List<String> tokens = _tokenize(expression);
    return _parseExpression(tokens);
  }

  List<String> _tokenize(String expression) {
    List<String> tokens = [];
    String current = '';
    String lastChar = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if ('+-*/()'.contains(char)) {
        if (current.isNotEmpty) {
          tokens.add(current);
          current = '';
        }

        // Handle unary operators
        if ((char == '+' || char == '-') &&
            (lastChar.isEmpty ||
                lastChar == '(' ||
                '+-*/'.contains(lastChar))) {
          current = char;
        } else {
          tokens.add(char);
        }
      } else {
        current += char;
      }

      lastChar = char;
    }

    if (current.isNotEmpty) {
      tokens.add(current);
    }

    return tokens;
  }

  double _parseExpression(List<String> tokens) {
    if (tokens.isEmpty) return 0;

    int index = 0;
    late double Function() parseAddSub;

    double parseNumber() {
      String token = tokens[index++];
      return double.parse(token);
    }

    double parseFactor() {
      if (tokens[index] == '(') {
        index++;
        double result = parseAddSub();
        if (index >= tokens.length || tokens[index] != ')') {
          throw CalculatorError(
            message: 'Mismatched parentheses',
            type: ErrorType.invalidExpression,
          );
        }
        index++;
        return result;
      } else {
        return parseNumber();
      }
    }

    double parseMulDiv() {
      double result = parseFactor();
      while (index < tokens.length &&
          (tokens[index] == '*' || tokens[index] == '/')) {
        String op = tokens[index++];
        double right = parseFactor();
        if (op == '*') {
          result *= right;
        } else {
          if (right.abs() < _epsilon) {
            throw CalculatorError(
              message: 'Division by zero',
              type: ErrorType.divisionByZero,
            );
          }
          result /= right;
        }
      }
      return result;
    }

    parseAddSub = () {
      double result = parseMulDiv();
      while (index < tokens.length &&
          (tokens[index] == '+' || tokens[index] == '-')) {
        String op = tokens[index++];
        double right = parseMulDiv();
        if (op == '+') {
          result += right;
        } else {
          result -= right;
        }
      }
      return result;
    };

    return parseAddSub();
  }
}
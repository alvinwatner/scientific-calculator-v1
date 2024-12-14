import 'dart:math';

class CalculatorService {
  String evaluate(String expression) {
    try {
      // Replace π with its value
      expression = expression.replaceAll('\u03c0', pi.toString());

      // Handle basic arithmetic and scientific functions
      double result = _evaluateExpression(expression);

      // Format the result
      if (result == result.roundToDouble()) {
        return result.toInt().toString();
      } else {
        return result
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0*$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    // Handle scientific functions
    expression = _handleScientificFunctions(expression);

    // Evaluate the resulting expression
    return _evaluateBasicExpression(expression);
  }

  String _handleScientificFunctions(String expression) {
    // Handle sin, cos, tan
    expression = _replaceTrigFunction(expression, 'sin');
    expression = _replaceTrigFunction(expression, 'cos');
    expression = _replaceTrigFunction(expression, 'tan');

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
          result = sin(value);
          break;
        case 'cos':
          result = cos(value);
          break;
        case 'tan':
          result = tan(value);
          break;
        default:
          throw Exception('Unknown function');
      }

      expression = expression.replaceFirst(
        regex,
        result.toString(),
      );
    }
    return expression;
  }

  double _evaluateBasicExpression(String expression) {
    // Simple parser for basic arithmetic
    List<String> tokens = _tokenize(expression);
    return _parseExpression(tokens);
  }

  List<String> _tokenize(String expression) {
    List<String> tokens = [];
    String current = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if ('+-*/()'.contains(char)) {
        if (current.isNotEmpty) {
          tokens.add(current);
          current = '';
        }
        tokens.add(char);
      } else {
        current += char;
      }
    }
    if (current.isNotEmpty) {
      tokens.add(current);
    }

    return tokens;
  }

  double _parseExpression(List<String> tokens) {
    if (tokens.isEmpty) return 0;

    int index = 0;

    double parseNumber() {
      return double.parse(tokens[index++]);
    }

    late double Function() parseAddSub;

    double parseFactor() {
      if (tokens[index] == '(') {
        index++;
        double result = parseAddSub();
        index++; // Skip closing parenthesis
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
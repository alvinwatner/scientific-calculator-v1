class CalculatorError implements Exception {
  final String message;
  final String? details;
  final ErrorType type;

  CalculatorError({
    required this.message,
    this.details,
    this.type = ErrorType.calculation,
  });

  @override
  String toString() => message;
}

enum ErrorType {
  divisionByZero,
  invalidExpression,
  overflow,
  underflow,
  invalidFunction,
  calculation,
}

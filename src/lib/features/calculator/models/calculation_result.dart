class CalculationResult {
  final String expression;
  final String result;
  final DateTime timestamp;
  final bool isError;

  CalculationResult({
    required this.expression,
    required this.result,
    required this.timestamp,
    this.isError = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
      'isError': isError,
    };
  }

  factory CalculationResult.fromJson(Map<String, dynamic> json) {
    return CalculationResult(
      expression: json['expression'] as String,
      result: json['result'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isError: json['isError'] as bool? ?? false,
    );
  }
}

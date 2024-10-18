abstract class CalculatorEvent {}

class NumberPressed extends CalculatorEvent {
  final String number;

  NumberPressed(this.number);
}

class OperatorPressed extends CalculatorEvent {
  final String operator;

  OperatorPressed(this.operator);
}

class CalculateResult extends CalculatorEvent {}

class Clear extends CalculatorEvent {}

class PercentagePressed extends CalculatorEvent {}

class NegatePressed extends CalculatorEvent {}

class DecimalPressed extends CalculatorEvent {}

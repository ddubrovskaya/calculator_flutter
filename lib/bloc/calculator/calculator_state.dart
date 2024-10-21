abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {
  final String display;

  CalculatorInitial(this.display);
}

class CalculatorResult extends CalculatorState {
  final String result;

  CalculatorResult(this.result);
}

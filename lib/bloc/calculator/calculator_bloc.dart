import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _currentInput = '';
  String _operator = '';
  double _firstOperand = 0.0;
  bool _isResultDisplayed = false;

  CalculatorBloc() : super(CalculatorInitial('0')) {
    on<NumberPressed>((event, emit) {
      if (_isResultDisplayed) {
        _currentInput = event.number;
        _isResultDisplayed = false;
      } else {
        _currentInput += event.number;
      }
      emit(CalculatorInitial(_currentInput));
    });

    on<OperatorPressed>((event, emit) {
      _firstOperand = double.tryParse(_currentInput) ?? 0.0;
      _operator = event.operator;
      _currentInput = '';
      _isResultDisplayed = false;
    });

    on<CalculateResult>((event, emit) {
      double secondOperand = double.tryParse(_currentInput) ?? 0.0;
      double result = 0.0;

      switch (_operator) {
        case '+':
          result = _firstOperand + secondOperand;
          break;
        case '-':
          result = _firstOperand - secondOperand;
          break;
        case '*':
          result = _firstOperand * secondOperand;
          break;
        case '/':
          result = _firstOperand / secondOperand;
          break;
      }

      String resultString =
          result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);

      emit(CalculatorResult(resultString));
      _currentInput = resultString;
      _isResultDisplayed = true;
    });

    on<Clear>((event, emit) {
      _currentInput = '';
      _operator = '';
      _firstOperand = 0.0;
      _isResultDisplayed = false;
      emit(CalculatorInitial('0'));
    });

    on<PercentagePressed>((event, emit) {
      double value = double.tryParse(_currentInput) ?? 0.0;
      value /= 100;
      _currentInput = value.toString();
      emit(CalculatorInitial(_currentInput));
    });

    on<NegatePressed>((event, emit) {
      if (_currentInput.isNotEmpty) {
        if (_currentInput.startsWith('-')) {
          _currentInput = _currentInput.substring(1);
        } else {
          _currentInput = '-$_currentInput';
        }
        emit(CalculatorInitial(_currentInput));
      }
    });

    on<DecimalPressed>((event, emit) {
      if (!_currentInput.contains('.')) {
        _currentInput += '.';
        emit(CalculatorInitial(_currentInput));
      }
    });
  }
}

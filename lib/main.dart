import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculator_bloc.dart';
import 'bloc/calculator_event.dart';
import 'bloc/calculator_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CalculatorBloc(),
        child: const CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              String display = '0';
              if (state is CalculatorInitial) {
                display = state.display;
              } else if (state is CalculatorResult) {
                display = state.result;
              }

              String clearButtonLabel = display == '0' ? 'AC' : 'C';
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      display,
                      style: const TextStyle(fontSize: 74, color: Colors.white),
                    ),
                  ),
                  //   },
                  // ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, clearButtonLabel),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '+/-'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '%'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '/'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '7'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '8'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '9'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '*'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '4'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '5'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '6'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '-'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '1'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '2'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '3'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '+'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '0'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '.'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildButton(context, '='),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    final darkGrayColor = Colors.grey[800];
    const grayColor = Colors.grey;
    const orangeColor = Colors.orange;

    Color buttonColor;
    if ('7894561230.'.contains(label)) {
      buttonColor = darkGrayColor!;
    } else if (label == 'C' || label == 'AC' || label == '%') {
      buttonColor = grayColor;
    } else if (label == '+/-') {
      buttonColor = grayColor;
    } else if ('+-/*='.contains(label)) {
      buttonColor = orangeColor;
    } else {
      buttonColor = Colors.white;
    }

    Color textColor;
    if (label == 'C' || label == 'AC' || label == '+/-' || label == '%') {
      textColor = Colors.black;
    } else {
      textColor = Colors.white;
    }

    return ElevatedButton(
      onPressed: () {
        final bloc = BlocProvider.of<CalculatorBloc>(context);
        if (label == 'C') {
          bloc.add(Clear());
        } else if (label == '=') {
          bloc.add(CalculateResult());
        } else if ('+-*/'.contains(label)) {
          bloc.add(OperatorPressed(label));
        } else if (label == '%') {
          bloc.add(PercentagePressed());
        } else if (label == '+/-') {
          bloc.add(NegatePressed());
        } else if (label == '.') {
          bloc.add(DecimalPressed());
        } else {
          bloc.add(NumberPressed(label));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: label == '0'
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )
            : const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 32, color: textColor),
      ),
    );
  }
}

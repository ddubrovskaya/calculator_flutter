import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:calculator_flutter/bloc/table/table.bloc.dart';
import 'package:calculator_flutter/bloc/webview/webview_bloc.dart';
import 'package:calculator_flutter/lifecycle_aware_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculator/calculator_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalculatorBloc>(
          create: (context) => CalculatorBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<WebViewBloc>(
          create: (context) => WebViewBloc(),
        ),
        BlocProvider<CarouselBloc>(
          create: (context) => CarouselBloc(),
        ),
        BlocProvider<TableBloc>(
          create: (context) => TableBloc(),
        ),
      ],
      child: MaterialApp(
        home: LifecycleAwareHome(),
      ),
    );
  }
}

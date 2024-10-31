import 'package:calculator_flutter/bloc/calculator/calculator_bloc.dart';
import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:calculator_flutter/bloc/table/table.bloc.dart';
import 'package:calculator_flutter/bloc/webview/webview_bloc.dart';
import 'package:calculator_flutter/calculator_screen.dart';
import 'package:calculator_flutter/carousel_widget.dart';
import 'package:calculator_flutter/lifecycle_aware_home.dart';
import 'package:calculator_flutter/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:calculator_flutter/detail_page.dart';
import 'package:calculator_flutter/home_screen.dart';

class MyStorybook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<CalculatorBloc>(
          create: (context) => CalculatorBloc(),
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
        home: Storybook(
          stories: [
            Story(
              name: 'LifecycleAwareHome Page',
              builder: (context) => const LifecycleAwareHome(),
            ),
            Story(
              name: 'Detail Page',
              builder: (context) => DetailPage(),
            ),
            Story(
              name: 'Home Screen - Trading View',
              builder: (context) => HomeScreen(pageIndex: 2),
            ),
            Story(
              name: 'Carousel Widget',
              builder: (context) => const CarouselWidget(),
            ),
            Story(
              name: 'Calculator Screen',
              builder: (context) => const CalculatorScreen(),
            ),
            Story(
              name: 'Trading View Widget',
              builder: (context) => const TradingViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

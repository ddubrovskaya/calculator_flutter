import 'dart:async';
import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:calculator_flutter/bloc/screenshot/screenshot_bloc.dart';
import 'package:calculator_flutter/bloc/screenshot/screenshot_event.dart';
import 'package:calculator_flutter/bloc/screenshot/screenshot_state.dart';
import 'package:calculator_flutter/bloc/table/table.bloc.dart';
import 'package:calculator_flutter/bloc/webview/webview_bloc.dart';
import 'package:calculator_flutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculator/calculator_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late ScreenshotBloc _screenshotBloc;
  final GlobalKey _boundaryKey = GlobalKey();
  bool _showMask = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _screenshotBloc = ScreenshotBloc(_boundaryKey);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _screenshotBloc.close();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     _screenshotBloc.add(CaptureScreenshot());
  //   } else if (state == AppLifecycleState.resumed) {
  //     _screenshotBloc.add(ShowScreenshot());
  //     Timer(const Duration(seconds: 4), () {
  //       _screenshotBloc.add(HideScreenshot());
  //     });
  //   }
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _showMask = true;
      });
      _screenshotBloc.add(CaptureScreenshot());
    } else if (state == AppLifecycleState.resumed) {
      _screenshotBloc.add(ShowScreenshot());
      Timer(const Duration(seconds: 4), () {
        _screenshotBloc.add(HideScreenshot());
        setState(() {
          _showMask = true;
        });
      });
    }
  }

//   @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   if (state == AppLifecycleState.paused) {
//     _screenshotBloc.add(ShowMask()); // Показать маску
//     _screenshotBloc.add(CaptureScreenshot());
//   } else if (state == AppLifecycleState.resumed) {
//     _screenshotBloc.add(ShowScreenshot());
//     Timer(const Duration(seconds: 4), () {
//       _screenshotBloc.add(HideScreenshot());
//       _screenshotBloc.add(HideMask()); // Скрыть маску
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScreenshotBloc>(
          create: (_) => _screenshotBloc,
        ),
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
        home: BlocBuilder<ScreenshotBloc, ScreenshotState>(
          builder: (context, state) {
            if (state is ScreenshotDisplayed) {
              return Scaffold(
                body: RepaintBoundary(
                  key: _boundaryKey,
                  child: Stack(
                    children: [
                      RawImage(image: state.image),
                      if (_showMask)
                        Positioned(
                          top: 400,
                          left: 20,
                          child: Container(
                            width: 350,
                            height: 350,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              body: RepaintBoundary(
                key: _boundaryKey,
                child: HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

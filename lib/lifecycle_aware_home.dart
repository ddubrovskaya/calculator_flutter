import 'package:calculator_flutter/home_screen.dart';
import 'package:flutter/material.dart';

enum AppVisibility { foreground, background }

class LifecycleAwareHome extends StatefulWidget {
  const LifecycleAwareHome({super.key});

  @override
  _LifecycleAwareHomeState createState() => _LifecycleAwareHomeState();
}

class _LifecycleAwareHomeState extends State<LifecycleAwareHome>
    with WidgetsBindingObserver {
  AppVisibility _appVisibility = AppVisibility.foreground;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      setState(() {
        _appVisibility = AppVisibility.background;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _appVisibility = AppVisibility.foreground;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeScreen(
          pageIndex: 0,
        ),
        if (_appVisibility == AppVisibility.background)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image.asset(
                'assets/icons/bitcoin.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
      ],
    );
  }
}

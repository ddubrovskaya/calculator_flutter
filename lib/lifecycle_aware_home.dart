import 'package:calculator_flutter/home_screen.dart';
import 'package:flutter/material.dart';

class LifecycleAwareHome extends StatefulWidget {
  @override
  _LifecycleAwareHomeState createState() => _LifecycleAwareHomeState();
}

class _LifecycleAwareHomeState extends State<LifecycleAwareHome>
    with WidgetsBindingObserver {
  bool _isInBackground = false;
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
        _isInBackground = true;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _isInBackground = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeScreen(),
        if (_isInBackground)
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
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

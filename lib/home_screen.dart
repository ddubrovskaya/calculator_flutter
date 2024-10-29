import 'package:calculator_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_event.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_state.dart';
import 'package:calculator_flutter/calculator_screen.dart';
import 'package:calculator_flutter/carousel_widget.dart';
import 'package:calculator_flutter/custom_bottom_navigation_bar.dart';
import 'package:calculator_flutter/menu_screen.dart';
import 'package:calculator_flutter/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _pages = [
    const CarouselWidget(),
    const CalculatorScreen(),
    const TradingViewWidget(),
    const Center(child: Text('Discover Page')),
    const Center(child: Text('Portfolio Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Image.asset('assets/icons/menu.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MenuScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          body: _pages[state.selectedIndex],
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(NavigateToPage(index));
            },
          ),
        );
      },
    );
  }
}

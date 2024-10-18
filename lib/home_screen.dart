import 'package:calculator_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_event.dart';
import 'package:calculator_flutter/bloc/navigation/navigation_state.dart';
import 'package:calculator_flutter/calculator_screen.dart';
import 'package:calculator_flutter/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _pages = [
    const Center(child: Text('Markets Page')),
    const Center(child: Text('Square Page')),
    const CalculatorScreen(),
    const Center(child: Text('Discover Page')),
    const Center(child: Text('Portfolio Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
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

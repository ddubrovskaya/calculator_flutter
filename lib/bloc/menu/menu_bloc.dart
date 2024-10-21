import 'package:calculator_flutter/bloc/menu/menu_event.dart';
import 'package:calculator_flutter/bloc/menu/menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(InitialMenuState());

  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is ProfileTapped) {
      yield ProfileTappedState();
    }
  }
}

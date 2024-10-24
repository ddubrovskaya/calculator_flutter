import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'html_event.dart';
import 'html_state.dart';

class HtmlBloc extends Bloc<HtmlEvent, HtmlState> {
  HtmlBloc() : super(HtmlLoading()) {
    on<LoadHtml>(_onLoadHtml);
  }

  Future<void> _onLoadHtml(LoadHtml event, Emitter<HtmlState> emit) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/html_content.json');
      final jsonMap = json.decode(jsonString);
      final htmlContent = jsonMap['html'];
      emit(HtmlLoaded(htmlContent));
    } catch (e) {
      emit(HtmlError(e.toString()));
    }
  }
}

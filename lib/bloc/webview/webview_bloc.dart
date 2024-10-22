import 'package:calculator_flutter/bloc/webview/webview_event.dart';
import 'package:calculator_flutter/bloc/webview/webview_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(WebViewInitial()) {
    on<LoadWebView>((event, emit) async {
      emit(WebViewLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(WebViewLoaded());
    });
  }
}

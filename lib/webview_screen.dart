import 'dart:convert';
import 'package:calculator_flutter/bloc/html/html_bloc.dart';
import 'package:calculator_flutter/bloc/html/html_event.dart';
import 'package:calculator_flutter/bloc/html/html_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:calculator_flutter/bloc/webview/webview_bloc.dart';
import 'package:calculator_flutter/bloc/webview/webview_event.dart';
// import 'package:calculator_flutter/bloc/webview/webview_state.dart';

class TradingViewWidget extends StatelessWidget {
  const TradingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WebViewBloc()..add(LoadWebView()),
        ),
        BlocProvider(
          create: (context) => HtmlBloc()..add(LoadHtml()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('TradingView Chart'),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<HtmlBloc, HtmlState>(
          builder: (context, state) {
            if (state is HtmlLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HtmlError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is HtmlLoaded) {
              final htmlContent = state.htmlContent;
              final controller = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {},
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onHttpError: (HttpResponseError error) {},
                    onWebResourceError: (WebResourceError error) {},
                  ),
                )
                ..loadRequest(
                  Uri.dataFromString(
                    htmlContent,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'),
                  ),
                );

              return Column(
                children: [
                  Expanded(
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:calculator_flutter/bloc/webview/webview_bloc.dart';
import 'package:calculator_flutter/bloc/webview/webview_event.dart';
import 'package:calculator_flutter/bloc/webview/webview_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewWidget extends StatelessWidget {
  const TradingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebViewBloc()..add(LoadWebView()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('TradingView Chart'),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<WebViewBloc, WebViewState>(
          builder: (context, state) {
            if (state is WebViewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WebViewLoaded) {
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
                    '''
                    <!DOCTYPE html>
                    <html>
                    <head>
                      <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    </head>
                    <body>
                      <!-- TradingView Widget BEGIN -->
                      <div class="tradingview-widget-container" style="height:100vh;width:100vw;">
                        <div class="tradingview-widget-container__widget" style="height:calc(100% - 42px);width:100%;"></div>
                        <div class="tradingview-widget-copyright">
                          <a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank">
                            <span class="blue-text">Track all markets on TradingView</span>
                          </a>
                        </div>
                        <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
                        {
                          "width": "395",
                          "height": "500",
                          "symbol": "COINBASE:BTCUSD",
                          "timezone": "Etc/UTC",
                          "theme": "light",
                          "style": "1",
                          "locale": "en",
                          "withdateranges": true,
                          "range": "YTD",
                          "allow_symbol_change": true,
                          "details": true,
                          "hotlist": true,
                          "calendar": false,
                          "show_popup_button": true,
                          "popup_width": "1000",
                          "popup_height": "650",
                          "support_host": "https://www.tradingview.com"
                        }
                        </script>
                      </div>
                      <!-- TradingView Widget END -->
                    </body>
                    </html>
                    ''',
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

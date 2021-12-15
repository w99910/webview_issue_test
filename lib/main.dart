import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WebView issue',
        home: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(letterSpacing: 0.9),
            title: const Text('Profile'),
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              return SafeArea(
                  child: Center(
                    child: Container(
                padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 20,
                    right: 20,
                ),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 140, height: 160, child: WebViewTest()),
                        const SizedBox(height: 18),
                        const Text('Rhys',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 10),
                        const Text('rhys@testmail.com',
                            style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 14),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 16),
                            ),
                            onPressed: () {
                              print('click');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      insetPadding: const EdgeInsets.symmetric(
                                          vertical: 24, horizontal: 26),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)),
                                      backgroundColor:
                                          Theme.of(context).scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0, horizontal: 16),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              SizedBox(
                                                  width: 120,
                                                  height: 140,
                                                  child: WebViewTest()),
                                              Text('Rhys',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18)),
                                              Text('rhys@testmail.com',
                                                  style: TextStyle(fontSize: 13)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Edit Profile',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_ios, size: 14)
                              ],
                            )),
                        const SizedBox(height: 28),
                      ],
                    ),
                ),
              ),
                  ));
            }
          ),
        ));
  }
}

const html =
    'data:text/html;base64,PCFET0NUWVBFIGh0bWw+PGh0bWw+PGhlYWQ+PG1ldGEgY2hhcnNldD0idXRmLTgiPjxtZXRhIG5hbWU9InZpZXdwb3J0IiBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MS4wLCBtYXhpbXVtLXNjYWxlPTEuMCwgbWluaW11bS1zY2FsZT0xLjAsIHVzZXItc2NhbGFibGU9MCIgLz48c3R5bGU+aHRtbCxib2R5e292ZXJmbG93OmhpZGRlbjt9PC9zdHlsZT48L2hlYWQ+PGJvZHk+PGRpdiBpZD0iYXBwIj48YXZhdGFhYXJzIHJlZj0iYXZhdGFyIj48L2F2YXRhYWFycz48L2Rpdj48L2JvZHk+PC9odG1sPg==';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  _WebViewTestState createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  WebViewController? _webViewController;

  double _opacity = Platform.isAndroid ? 0.0 : 1.0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: AbsorbPointer(
        child: WebView(
          debuggingEnabled: true,
          initialUrl: html,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: false,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
          },
          onPageFinished: (String url) {
            if (Platform.isAndroid) {
              setState(() {
                _opacity = 1.0;
              });
            }
          },
        ),
      ),
    );
  }
}
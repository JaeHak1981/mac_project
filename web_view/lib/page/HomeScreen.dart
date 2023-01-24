import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  final homeUrl =
      'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf';
  WebViewController? controller;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                if (controller == null) {
                  return;
                }
                controller!.loadUrl(homeUrl);
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: WebView(
        initialUrl: homeUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse(
    'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeUrl);

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.red,
        title: Align(
          alignment: Alignment.center,
            child: Text(
          'WebView',
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          IconButton(
              onPressed: () {
                controller.loadRequest(homeUrl);
              },
              icon: Icon(
                Icons.home,
                size: 40,
              ))
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

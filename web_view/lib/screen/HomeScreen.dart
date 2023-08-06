import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse(
    'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf?pvs=4');

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(homeUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Page',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
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
      body: WebViewWidget(controller: controller),
    );
  }
}

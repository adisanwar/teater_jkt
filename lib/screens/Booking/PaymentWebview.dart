import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentWebView extends StatefulWidget {
  String url;
  PaymentWebView({required this.url, Key? key}) : super(key: key);
  @override
  State<PaymentWebView> createState() => _WebViewScreenState();
}
class _WebViewScreenState extends State<PaymentWebView> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TextConstants.appBarTitle'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
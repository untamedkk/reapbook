import 'package:flutter/material.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String url;

  FullScreenImageScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Image.network(
        url,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  static void open(BuildContext context, String url) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FullScreenImageScreen(url)),
      );
}

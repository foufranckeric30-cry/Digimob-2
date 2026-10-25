import 'package:flutter/material.dart';

class AppRouter {
  static const String initialRoute = '/';

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const _PlaceholderScreen(
          title: 'DigiCâble',
          message: 'Architecture initialisée',
        ),
  };
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String message;

  const _PlaceholderScreen({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
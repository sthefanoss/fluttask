import 'package:fluttask/routing/named_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlutTaskApp());
}

class FlutTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: namedRoutes,
    );
  }
}

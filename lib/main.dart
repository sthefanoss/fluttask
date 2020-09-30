import 'package:fluttask/routing/bindings/initial_bindings.dart';
import 'package:fluttask/routing/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(FlutTaskApp());

class FlutTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: appPages,
      initialBinding: InitialBindings(),
    );
  }
}

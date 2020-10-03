import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends AlertDialog {
  final String titleText;
  final String subtitleText;

  CustomAlertDialog({
    this.titleText,
    this.subtitleText,
  }) : super(title: Text(titleText), content: Text(subtitleText), actions: [
          FlatButton(
            child: Text('Não'),
            onPressed: () => Get.back(result: false),
          ),
          FlatButton(
            child: Text('Sim'),
            onPressed: () => Get.back(result: true),
          )
        ]);

  Future show() async {
    return await Get.dialog(this, barrierDismissible: false);
  }
}

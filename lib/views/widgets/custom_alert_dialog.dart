import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends AlertDialog {
  final String titleText;
  final String subtitleText;
  final Function onConfirmAction;

  CustomAlertDialog({
    this.titleText,
    this.subtitleText,
    this.onConfirmAction,
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

  void show() {
    Get.dialog(this, barrierDismissible: false).then((value) {
      if (value) onConfirmAction();
    });
  }
}

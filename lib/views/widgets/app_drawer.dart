import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:fluttask/views/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 80,
            width: double.infinity,
            child: SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16),
                child: Text(
                  authController.user.value.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              onTap: () {
                CustomAlertDialog(
                  titleText: "Sair",
                  subtitleText: "Tens certeza que desejas sair da sua conta?",
                  onConfirmAction: () {
                    Get.back();
                    authController.logout();
                    Get.offAndToNamed(RouteNames.home);
                  },
                ).show();
              },
            ),
          )
        ],
      ),
    );
  }
}

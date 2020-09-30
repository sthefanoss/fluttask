import 'package:fluttask/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Container(
            padding:  const  EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                ),
               const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Registrar'),
                      onPressed: _navigateToRegistrationPage,
                    ),
                    RaisedButton(
                      child: Text('Entrar'),
                      onPressed: _login,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToRegistrationPage() {
    Get.toNamed(RouteNames.registrationForm);
  }

  Future<void> _login() async {}
}

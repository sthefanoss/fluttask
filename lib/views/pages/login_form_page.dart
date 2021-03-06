import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/data/models/credentials.dart';
import 'package:fluttask/helpers/validators.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.43),
                Colors.pink.withOpacity(0.43),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Transform.rotate(
                  angle: -3.14 / 25,
                  child: Text(
                    "FlutTask ✓",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.pink,
                        ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(4),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (text) {
                    if (text.isEmpty) return "E-mail é um campo obrigatório.";
                    if (!emailValidator(text)) return "E-mail inválido.";
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(4),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Text('Registrar'),
                    color: Colors.black.withOpacity(0.5),
                    onPressed: _navigateToRegistrationPage,
                  ),
                  FlatButton(
                    child: Text('Entrar'),
                    color: Colors.black.withOpacity(0.5),
                    onPressed: _login,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRegistrationPage() {
    Get.toNamed(RouteNames.registrationForm);
  }

  Future<void> _login() async {
    bool wasSuccessful = await authController.login(
      Credentials(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.hashCode.toString(),
      ),
    );

    if (wasSuccessful) {
      scaffoldKey.currentState.hideCurrentSnackBar();
      Get.offAndToNamed(RouteNames.tasksOverview);
    } else {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Login inválido."),
        ),
      );
    }
  }
}

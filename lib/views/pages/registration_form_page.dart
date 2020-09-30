import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationFormPage extends StatefulWidget {
  @override
  _RegistrationFormPageState createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final cepController = TextEditingController();
  final locationController = TextEditingController();
  final numberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    cpfController.dispose();
    cepController.dispose();
    locationController.dispose();
    numberController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Usuário"),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.all(32),
                  children: [
                    Text(
                      "Dados Pessoais",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome *'),
                    ),
                    TextFormField(
                      controller: cpfController,
                      decoration: InputDecoration(labelText: 'CPF'),
                    ),
                    TextFormField(
                      controller: dateOfBirthController,
                      decoration:
                          InputDecoration(labelText: 'Data de Nascimento *'),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Credenciais",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'E-mail *'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Senha *'),
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration:
                          InputDecoration(labelText: 'Confirmar Senha *'),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Endereço",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      controller: cepController,
                      decoration: InputDecoration(labelText: 'CEP'),
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(labelText: 'Endereço'),
                    ),
                    TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(labelText: 'Número'),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text('Voltar'),
                          onPressed: _navigateBack,
                        ),
                        RaisedButton(
                          child: Text('Registrar'),
                          onPressed: _accept,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateBack() {
    Get.back();
  }

  Future<void> _accept() async {}
}

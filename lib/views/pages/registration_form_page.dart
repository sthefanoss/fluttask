import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/data/models/address.dart';
import 'package:fluttask/data/models/credentials.dart';
import 'package:fluttask/data/models/user.dart';
import 'package:fluttask/data/repository/network/api_endpoints.dart';
import 'package:fluttask/helpers/date_parser.dart';
import 'package:fluttask/helpers/validators.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  final dateOfBirthFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formKey = GlobalKey<FormState>();

  static const int minimumAge = 12;
  bool isAwaiting = false;

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
                      enabled: !isAwaiting,
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome *'),
                      validator: (text) {
                        if (text.isEmpty) return "Nome é um campo obrigatório.";
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: cpfController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'CPF'),
                      inputFormatters: [cpfFormatter],
                      validator: (text) {
                        if (text.isNotEmpty && !cpfValidator(text))
                          return "CPF Inválido";
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento *',
                        hintText: "dd/mm/aaaa",
                      ),
                      inputFormatters: [dateOfBirthFormatter],
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text.isEmpty)
                          return "Data de Nascimento é um campo obrigatório.";
                        if (DateTimeFormatter.decode(text) == null)
                          return "Data de Nascimento inválida";
                        if (_minimumAgeValidator(text))
                          return "Você deve ter $minimumAge para se registrar.";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Credenciais",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'E-mail *'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty)
                          return "E-mail é um campo obrigatório.";
                        if (!emailValidator(text)) return "E-mail inválido.";
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Senha *'),
                      obscureText: true,
                      validator: (text) {
                        if (text.length < 6)
                          return "Deve ter pelo 6 caracteres.";
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: confirmPasswordController,
                      decoration:
                          InputDecoration(labelText: 'Confirmar Senha *'),
                      obscureText: true,
                      validator: (text) {
                        if (text.length < 6)
                          return "Deve ter pelo 6 caracteres.";
                        if (text != passwordController.text)
                          return "As senhas são diferentes.";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Endereço",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      keyboardType: TextInputType.number,
                      controller: cepController,
                      decoration: InputDecoration(labelText: 'CEP'),
                      inputFormatters: [cepFormatter],
                      validator: _cepValidator,
                      onChanged: _updateLocation,
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: locationController,
                      decoration: InputDecoration(labelText: 'Endereço'),
                    ),
                    TextFormField(
                      enabled: !isAwaiting,
                      controller: numberController,
                      keyboardType: TextInputType.number,
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
                          onPressed: Get.back,
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

  bool _minimumAgeValidator(String dateAsString) {
    Duration dateDifference =
        DateTime.now().difference(DateTimeFormatter.decode(dateAsString));
    //Média de dias em um ano considerando ano bissexto
    //Não é o ideal, mas é mais preciso do que simplesmente dividir por 365 e truncar
    double yearsDifference = dateDifference.inDays / 365.25;
    return yearsDifference < minimumAge;
  }

  String _cepValidator(text) {
    if (text.isNotEmpty && text.length != 9) return "CEP inválido.";
    return null;
  }

  void _updateLocation(text) {
    if (text.length != 9) return;

    ApiEndpoints.getLocationFromCep(cepController.text).then(
      (location) {
        setState(() => locationController.text = location);
      },
    );
  }

  Future<void> _accept() async {
    if (isAwaiting) return;
    if (!formKey.currentState.validate()) return;

    setState(() => isAwaiting = true);

    bool wasSuccessful =
        await Get.find<AuthController>().registerUser(_getUserFromForm());

    if (wasSuccessful) {
      Get.offAllNamed(RouteNames.tasksOverview);
    } else {
      setState(() => isAwaiting = false);
    }
  }

  User _getUserFromForm() {
    return User(
      name: nameController.text,
      cpf: cpfController.text,
      dateOfBirth: DateTimeFormatter.decode(dateOfBirthController.text),
      credentials: Credentials(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.hashCode.toString(),
      ),
      address: Address(
        cep: cepController.text,
        number: numberController.text,
        location: locationController.text,
      ),
    );
  }

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
}

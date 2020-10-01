import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/helpers/date_parser.dart';
import 'package:fluttask/models/task.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class TaskFormPage extends StatefulWidget {
  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final tasksController = Get.find<TasksController>();
  final authController = Get.find<AuthController>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateOfDeliveryController = TextEditingController();
  final dateOfConclusionController = TextEditingController();

  final dateOfDeliveryFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final dateOfConclusionFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formKey = GlobalKey<FormState>();

  bool isAwaiting = false;
  Task oldTask;

  @override
  void initState() {
    oldTask = Get.arguments;
    if (oldTask != null) {
      nameController.text = oldTask.name;
      descriptionController.text = oldTask.description;
      dateOfDeliveryController.text =
          DateTimeFormatter.encode(oldTask.dateOfDelivery);
      dateOfConclusionController.text = oldTask.dateOfConclusion != null
          ? DateTimeFormatter.encode(oldTask.dateOfConclusion)
          : '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(oldTask == null ? "Nova Tarefa" : "Editar Tarefa"),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              TextFormField(
                enabled: !isAwaiting,
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome *'),
                maxLength: 40,
                validator: (text) {
                  if (text.isEmpty) return "Nome não pode ser nulo.";
                  return null;
                },
              ),
              TextFormField(
                enabled: !isAwaiting,
                controller: dateOfDeliveryController,
                decoration: InputDecoration(labelText: 'Data de Entrega *'),
                inputFormatters: [dateOfDeliveryFormatter],
                validator: (text) {
                  if (text.isEmpty) return "Data de Entrega não pode ser nula.";
                  if (DateTimeFormatter.decode(text, isInFiveYears) == null)
                    return "Data de Entrega inválida.";
                  return null;
                },
              ),
              TextFormField(
                enabled: !isAwaiting,
                controller: dateOfConclusionController,
                decoration: InputDecoration(labelText: 'Data de Conclusão'),
                inputFormatters: [dateOfConclusionFormatter],
                validator: (text) {
                  if (text.isNotEmpty &&
                      DateTimeFormatter.decode(text, isInFiveYears) == null)
                    return "Data de Conclusão inválida.";
                  return null;
                },
              ),
              TextFormField(
                enabled: !isAwaiting,
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLength: 400,
                minLines: 5,
                maxLines: 6,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _save,
      ),
    );
  }

  bool isInFiveYears(DateTime date, DateTime now) =>
      (date.year - now.year).abs() > 5;

  Future<void> _save() async {
    if (isAwaiting) return;
    if (!formKey.currentState.validate()) return;

    setState(() => isAwaiting = true);

    bool wasSuccessful = await tasksController.createOrEditTask(Task(
      //TODO userId:  authController.user.value.id;
      id: oldTask == null ? DateTime.now().toIso8601String() : oldTask.id,
      name: nameController.text,
      description: descriptionController.text,
      dateOfDelivery: DateTimeFormatter.decode(dateOfDeliveryController.text),
      dateOfConclusion: DateTimeFormatter.decode(
        dateOfConclusionController.text,
      ),
    ));

    if (wasSuccessful)
      Get.back();
    else
      setState(() => isAwaiting = false);
  }
}

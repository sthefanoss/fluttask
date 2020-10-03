import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/data/models/task.dart';
import 'package:fluttask/helpers/date_parser.dart';
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
                  if (text.isEmpty) return "Nome é um campo obrigatório.";
                  return null;
                },
              ),
              TextFormField(
                enabled: !isAwaiting,
                controller: dateOfDeliveryController,
                decoration: InputDecoration(
                  labelText: 'Data de Entrega *',
                  hintText: "dd/mm/aaaa",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [dateOfDeliveryFormatter],
                validator: (text) {
                  if (text.isEmpty) return "Data de Entrega é um campo obrigatório.";
                  if (DateTimeFormatter.decode(text) == null)
                    return "Data de Entrega inválida.";
                  return null;
                },
              ),
              TextFormField(
                enabled: !isAwaiting,
                controller: dateOfConclusionController,
                decoration: InputDecoration(
                  labelText: 'Data de Conclusão',
                  hintText: "dd/mm/aaaa",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [dateOfConclusionFormatter],
                validator: (text) {
                  if (text.isNotEmpty && DateTimeFormatter.decode(text) == null)
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

  Future<void> _save() async {
    if (isAwaiting) return;
    if (!formKey.currentState.validate()) return;

    setState(() => isAwaiting = true);

    bool wasSuccessful;
    if (oldTask == null)
      wasSuccessful = await tasksController.createTask(_getTaskFromForm());
    else
      wasSuccessful =
          await tasksController.editTask(oldTask.id, _getTaskFromForm());

    if (wasSuccessful) {
      Get.back();
    } else {
      setState(() => isAwaiting = false);
    }
  }

  Task _getTaskFromForm() {
    return Task(
      name: nameController.text,
      description: descriptionController.text,
      dateOfDelivery: DateTimeFormatter.decode(
        dateOfDeliveryController.text,
      ),
      dateOfConclusion: DateTimeFormatter.decode(
        dateOfConclusionController.text,
      ),
    );
  }
}

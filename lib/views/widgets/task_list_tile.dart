import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/data/models/task.dart';
import 'package:fluttask/helpers/date_parser.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:fluttask/views/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListTile extends StatefulWidget {
  final Task task;

  TaskListTile(
    this.task,
  ) : super(key: Key(task.id));

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  final tasksController = Get.find<TasksController>();
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      confirmDismiss: (_) async {
        return await CustomAlertDialog(
          titleText: "Excluir Tarefa?",
          subtitleText: "Desejas realmente excluir a tarefa "
              "${widget.task.name}?",
        ).show();
      },
      onDismissed: (_) => tasksController.deleteTask(widget.task.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(widget.task.name),
              subtitle: Text(_tileSubtitle()),
              onTap: () => setState(() => isCollapsed = !isCollapsed),
              leading: Checkbox(
                onChanged: (_) => _showModalAndConcludeTask(),
                value: widget.task.isConcluded,
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Get.toNamed(
                  RouteNames.taskForm,
                  arguments: widget.task,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _tileSubtitle() {
    String _subtitle =
        'Entrega: ${DateTimeFormatter.encode(widget.task.dateOfDelivery)}';
    if (widget.task.dateOfConclusion != null)
      _subtitle +=
          '\nConclusão ${DateTimeFormatter.encode(widget.task.dateOfConclusion)}';
    if (widget.task.description.length > 0 && !isCollapsed)
      _subtitle += '\n\n${widget.task.description}';

    return _subtitle;
  }

  Widget _customIconButton(IconData icon, Function function) {
    return GestureDetector(
      onTap: function,
      child: Container(padding: const EdgeInsets.all(4), child: Icon(icon)),
    );
  }

  Future<void> _showModalAndConcludeTask() async {
    if (widget.task.isConcluded) return;

    bool response = await CustomAlertDialog(
      titleText: "Concluir Tarefa?",
      subtitleText: "Desejas dar a tarefa "
          "${widget.task.name} como concluída?",
    ).show();

    if (response) tasksController.concludeTask(widget.task.id);
  }
//
//  void _showModalAndDeleteTask() {
//    CustomAlertDialog(
//      titleText: "Excluir Tarefa?",
//      subtitleText: "Desejas realmente excluir a tarefa "
//          "${widget.task.name}}?",
//      onConfirmAction: () => tasksController.deleteTask(widget.task.id),
//    ).show();
//  }
}

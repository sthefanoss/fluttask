import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:fluttask/views/widgets/custom_alert_dialog.dart';
import 'package:fluttask/views/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListView extends StatelessWidget {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => tasksController.tasks.isEmpty
          ? Center(
              child: Text(
                "Você ainda não possui tarefas.",
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) => TaskListTile(
                task: tasksController.tasks[index],
                onEditClick: () => Get.toNamed(
                  RouteNames.taskForm,
                  arguments: tasksController.tasks[index],
                ),
                onConcludeClick: () => _showModalAndConcludeTask(index),
                onDeleteClick: () => _showModalAndDeleteTask(index),
              ),
              itemCount: tasksController.tasks.length,
            ),
    );
  }

  void _showModalAndConcludeTask(int index) {
    CustomAlertDialog(
      titleText: "Concluir Tarefa?",
      subtitleText: "Desejas dar a tarefa "
          "${tasksController.tasks[index].name} como concluída?",
      onConfirmAction: () =>
          tasksController.concludeTask(tasksController.tasks[index].id),
    ).show();
  }

  void _showModalAndDeleteTask(int index) {
    CustomAlertDialog(
      titleText: "Excluir Tarefa?",
      subtitleText: "Desejas realmente excluir a tarefa "
          "${tasksController.tasks[index].name}?",
      onConfirmAction: () =>
          tasksController.deleteTask(tasksController.tasks[index].id),
    ).show();
  }
}

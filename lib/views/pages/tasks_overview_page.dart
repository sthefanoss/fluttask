import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:fluttask/views/widgets/app_drawer.dart';
import 'package:fluttask/views/widgets/custom_alert_dialog.dart';
import 'package:fluttask/views/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksOverviewPage extends StatefulWidget {
  @override
  _TasksOverviewPageState createState() => _TasksOverviewPageState();
}

class _TasksOverviewPageState extends State<TasksOverviewPage> {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutTask"),
      ),
      drawer: AppDrawer(),
      body: Obx(
        () => tasksController.tasks.isEmpty
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(48),
                child: Text(
                  "Parece que você ainda não possui tarefas.",
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
                  onConcludeClick: () => showModalAndConcludeTask(index),
                  onDeleteClick: () => showModalAndDeleteTask(index),
                ),
                itemCount: tasksController.tasks.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed(RouteNames.taskForm),
      ),
    );
  }

  void showModalAndConcludeTask(int index) {
    CustomAlertDialog(
      titleText: "Concluir Tarefa?",
      subtitleText: "Desejas dar a tarefa "
          "${tasksController.tasks[index].name} como concluída?",
      onConfirmAction: () =>
          tasksController.concludeTask(tasksController.tasks[index].id),
    ).show();
  }

  void showModalAndDeleteTask(int index) {
    CustomAlertDialog(
      titleText: "Excluir Tarefa?",
      subtitleText: "Desejas realmente excluir a tarefa "
          "${tasksController.tasks[index].name}?",
      onConfirmAction: () =>
          tasksController.deleteTask(tasksController.tasks[index].id),
    ).show();
  }
}

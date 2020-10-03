import 'package:fluttask/constrollers/tasks_controller.dart';
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
              itemCount: tasksController.tasks.length,
              itemBuilder: (context, index) => TaskListTile(
                tasksController.tasks[index],
              ),
            ),
    );
  }
}

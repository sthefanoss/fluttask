import 'package:fluttask/constrollers/tasks_controller.dart';
import 'package:fluttask/routing/route_names.dart';
import 'package:fluttask/views/widgets/app_drawer.dart';
import 'package:fluttask/views/widgets/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksOverviewPage extends StatelessWidget {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutTask"),
      ),
      drawer: AppDrawer(),
      body: TaskListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed(RouteNames.taskForm),
      ),
    );
  }
}

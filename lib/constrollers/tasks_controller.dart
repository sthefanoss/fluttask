import 'package:get/get.dart';
import '../models/task.dart';

class TasksController extends GetxController {
  final tasks = RxList<Task>([]);

  Future<void> init() async {
    //TODO
  }

  Future<void> createTask(Task task) async {
    //TODO
  }

  Future<void> excludeTask(int id) async {
    //TODO
  }

  Future<void> updateTask(Task updatedTask) async {
    //TODO
  }

  Future<void> concludeTask(int id) async {
    //TODO
  }
}

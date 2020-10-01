import 'package:get/get.dart';
import '../models/task.dart';

class TasksController extends GetxController {
  final tasks = RxList<Task>([]);

  Future<bool> init() async {
    //TODO
  }

  Future<bool> createOrEditTask(Task task) async {
    final int taskIndex = _findTaskIndexById(task.id);

    if (taskIndex == -1) {
      tasks.add(task);
    } else {
      tasks[taskIndex] = tasks[taskIndex].copyWith(
          name: task.name,
          description: task.description,
          dateOfConclusion: task.dateOfConclusion,
          dateOfDelivery: task.dateOfDelivery);
    }

    return true;
  }

  Future<bool> deleteTask(String id) async {
    final int taskIndex = _findTaskIndexById(id);

    tasks.removeAt(taskIndex);

    return true;
  }

  Future<bool> concludeTask(String id) async {
    final int taskIndex = _findTaskIndexById(id);
    print(taskIndex);

    if (tasks[taskIndex].isConcluded) return false;

    tasks[taskIndex] = tasks[taskIndex].copyWith(
      isConcluded: true,
      dateOfConclusion: tasks[taskIndex].dateOfConclusion ?? DateTime.now(),
    );

    return true;
  }

  int _findTaskIndexById(String id) {
    return tasks.indexWhere((task) => task.id == id);
  }
}

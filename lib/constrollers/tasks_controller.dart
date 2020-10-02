import 'package:fluttask/constrollers/auth_controller.dart';
import 'package:fluttask/data/models/task.dart';
import 'package:fluttask/data/repository/repository.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final authController = Get.find<AuthController>();
  final tasks = RxList<Task>();
  final hasInit = RxBool(false);

  @override
  Future<void> onInit() async {
    tasks.value = await Repository.getTasks(
      authController.user.value.credentials,
    );

    hasInit.value = true;
  }

  Future<bool> createTask(Task task) async {
    Task modifiedTask = task.copyWith(
      userEmail: authController.user.value.credentials.email,
      id: DateTime.now().toIso8601String(),
    );

    bool wasSuccessful = await Repository.addTask(modifiedTask);

    if (wasSuccessful) tasks.add(modifiedTask);

    return wasSuccessful;
  }

  Future<bool> editTask(Task task) async {
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

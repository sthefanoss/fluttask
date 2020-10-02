import 'package:fluttask/models/credentials.dart';
import 'package:fluttask/models/task.dart';
import 'package:fluttask/models/user.dart';

import 'local/storage.dart';
import 'network/api_endpoints.dart';

abstract class Repository {
  static Future<bool> addUser(User user) async {
    return Storage.addUser(user);
  }

  static Future<User> login(Credentials credentials) async {
    return await Storage.login(credentials);
  }

  static Future<bool> addTask(Task task) async {
    return Storage.addTask(task);
  }

  static Future<bool> updateTask(Task task) async {
    return Storage.updateTask(task);
  }

  static Future<bool> removeTask(int taskId) async {
    return Storage.removeTask(taskId);
  }

  static Future<String> getLocationFromCep(String cep) async {
    return await ApiEndpoints.getLocationFromCep(cep);
  }
}

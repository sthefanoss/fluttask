import 'package:fluttask/data/repository/repository.dart';
import 'package:get/get.dart';
import '../models/credentials.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final user = Rx<User>();

  Future<bool> registerUser(User user) async {
    bool wasSuccessful = await Repository.addUser(user);
    if (wasSuccessful) this.user.value = user;

    return wasSuccessful;
  }

  Future<bool> login(Credentials credentials) async {
    User user = await Repository.login(credentials);
    if (user == null) return false;

    this.user.value = user;
    return true;
  }

  void logout() {
    user.value = null;
  }
}

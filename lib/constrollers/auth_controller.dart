import 'package:get/get.dart';
import '../models/credentials.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final user = Rx<User>();

  Future<bool> login(Credentials credentials) async {
    //TODO
  }

  Future<void> logout() async {
    //TODO
  }

  Future<bool> registerUser(User user) async {
    return false;
    //TODO
  }
}

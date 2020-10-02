import 'package:fluttask/models/credentials.dart';
import 'package:fluttask/models/task.dart';
import 'package:fluttask/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Storage {
  static Database _database;

  static Future<void> _openDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'fluttask.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE IF NOT EXISTS users"
          "(email TEXT PRIMARY KEY, name TEXT, dateOfBirth TEXT,"
          "cpf TEXT, password TEXT, cep TEXT, location TEXT, number TEXT)",
        );
        db.execute(
          "CREATE TABLE IF NOT EXISTS tasks"
          "(id INTEGER PRIMARY KEY, name TEXT, description TEXT, isConcluded INTEGER"
          "userEmail TEXT, dateOfDelivery TEXT, dateOfConclusion TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<Database> _getDataBase() async {
    if (_database == null) await _openDatabase();

    return _database;
  }

  static Future<bool> addUser(User user) async {
    try {
      final dataBase = await _getDataBase();

      await dataBase.insert('users', user.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<User> login(Credentials credentials) async {
    try {
      final dataBase = await _getDataBase();

      final userData = await dataBase.query(
        "USERS",
        where: "email = ? AND password = ?",
        whereArgs: [credentials.email, credentials.password],
        limit: 1,
      );

      return User.fromMap(userData.first);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> addTask(Task task) async {}

  static Future<bool> updateTask(Task task) async {}

  static Future<bool> removeTask(int taskId) async {}
}

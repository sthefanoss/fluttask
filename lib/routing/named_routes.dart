import 'package:fluttask/routing/bindings/home_bindings.dart';
import 'package:get/get.dart';
import '../routing/route_names.dart';
import '../views/pages/login_form_page.dart';
import '../views/pages/registration_form_page.dart';
import '../views/pages/task_form_page.dart';
import '../views/pages/tasks_overview_page.dart';

final appPages = <GetPage>[
  GetPage(
    name: RouteNames.home,
    page: () => LoginFormPage(),
  ),
  GetPage(
    name: RouteNames.registrationForm,
    page: () => RegistrationFormPage(),
  ),
  GetPage(
    name: RouteNames.taskForm,
    page: () => TaskFormPage(),
    binding: TasksBindings(),
  ),
  GetPage(
    name: RouteNames.tasksOverview,
    page: () => TasksOverviewPage(),
    binding: TasksBindings(),
  ),
];

import 'package:flutter/widgets.dart';
import '../routing/route_names.dart';
import '../views/pages/login_form_page.dart';
import '../views/pages/registration_form_page.dart';
import '../views/pages/task_form_page.dart';
import '../views/pages/tasks_overview_page.dart';

final namedRoutes = <String, WidgetBuilder>{
  RouteNames.home: (context) => LoginFormPage(),
  RouteNames.registrationForm: (context) => RegistrationFormPage(),
  RouteNames.taskForm: (context) => TaskFormPage(),
  RouteNames.tasksOverview: (context) => TasksOverviewPage(),
};

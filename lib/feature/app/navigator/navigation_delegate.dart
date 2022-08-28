import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/navigator/navigator_state.dart';
import 'package:done/feature/main_page/task_list_screen.dart';
import 'package:done/feature/task/task_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NavigationDelegate extends RouterDelegate<NavigatorConfigState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigatorConfigState> {
  Task? task;
  late bool isNew = true;

  final BehaviorSubject<List<Task>> tasksStream;

  NavigationDelegate({
    required this.task,
    required this.tasksStream,
  });

  void openList() {
    task = null;
    isNew = false;
    AppMetrica.reportEvent('Navigation transition to TaskListScreen');
    notifyListeners();
  }

  void createNewTask() {
    task = Task.initial();
    isNew = true;
    AppMetrica.reportEvent('Navigation transition to EditTaskScreen to create new task');
    notifyListeners();
  }

  void editTask(Task task) {
    task = task;
    isNew = false;
    AppMetrica.reportEvent('Navigation transition to EditTaskScreen to edit task');
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        MaterialPage(
          child: TaskListScreen(
            navigatorCallback: (t) {
              task = t;
              isNew = false;
              notifyListeners();
            },
          ),
        ),
        if (task != null)
          MaterialPage(
            child: TaskEditScreen(
              task: task,
              isNew: isNew,
            ),
          ),
      ],
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey();

  @override
  Future<void> setNewRoutePath(NavigatorConfigState configuration) async {
    if (configuration is NavigatorTaskState) {
      if (configuration.id != null) {
        final tasks = tasksStream.value;
        try {
          task = tasks.firstWhere((element) => element.id == configuration.id);
          isNew = false;
        } catch (e) {
          task = Task.initial();
          isNew = true;
        }
      } else {
        task = Task.initial();
        isNew = true;
      }
    } else {
      task = null;
      isNew = true;
    }
    notifyListeners();
  }
}

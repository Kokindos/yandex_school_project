import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/navigator/navigator_state.dart';
import 'package:done/feature/main_page/task_list_screen.dart';
import 'package:done/feature/task/task_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NavigationDelegate extends RouterDelegate<NavigatorConfigState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigatorConfigState> {
  Task? task;
  var isNew = false;

  final BehaviorSubject<List<Task>> tasksStream;

  NavigationDelegate({
    required this.task,
    required this.tasksStream,
  });

  void openList() {
    task = null;
    isNew = false;
    notifyListeners();
  }

  void createNewTask() {
    task = Task.initial();
    isNew = true;
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
        if (task == Task.initial())
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
      final tasks = tasksStream.value;
      final index =
          tasks.indexWhere((element) => element.id == configuration.id);
      if (index != -1) {
        task = tasks[index];
      }
    } else {
      task = null;
    }
    notifyListeners();
  }
}

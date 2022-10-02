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

  void createNewTask() {
    AppMetrica.reportEvent('Navigation transition to EditTaskScreen to create new task');
    task = Task.initial();
    isNew = true;
    notifyListeners();
  }

  void editTask(Task task) {
    AppMetrica.reportEvent('Navigation transition to EditTaskScreen to edit task');
    task = task;
    isNew = false;
    notifyListeners();
  }
  void openList() {
    AppMetrica.reportEvent('Navigation transition to TaskListScreen');
    task = null;
    isNew = false;
    notifyListeners();
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (task!=null){
          openList();
        }
        popRoute();
        return true;
      },
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

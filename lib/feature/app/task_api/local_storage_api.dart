import 'dart:developer';

import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:hive/hive.dart';
import '../../../logger.dart';
import 'task_api.dart';

class LocalStorageApi implements TaskApi {
  @override
  Future<Task> createTask({required Task task, int? revision}) async {
    log('LOCAL CREATE TASK');
    final box = Hive.box<Task>('tasks');
    box.put(task.id, task);
    return task;
  }

  @override
  Future<Task> deleteTask({required String id, int? revision}) async {
    final box = Hive.box<Task>('tasks');
    Task task = box.get(id)!;
    box.delete(id);
    return task;
  }

  @override
  Future<Task> editTask({required Task task, int? revision}) async {
    final box = Hive.box<Task>('tasks');
    await box.put(task.id, task);
    return task;
  }

  @override
  Future<List<Task>> getList() async {
    log('local storage get list');
    final box = Hive.box<Task>('tasks');
    log('ERROR 1');
    final List<dynamic> tasklist = box.values.cast().toList();

    final newlist = tasklist.map((e) => e as Task).toList();

    log('local storage newlist');
    return newlist;
  }

  @override
  Future<Task> getTask({required String id, int? revision}) async {
    final box = Hive.box<Task>('tasks');
    Task task = box.get(id)!;
    return task;
  }

  @override
  Future<List<Task>> updateList(
      {required List<Task> taskList, int? revision}) async {
    final box = Hive.box<Task>('tasks');
    for (var task in taskList) {
      box.put(task.id, task);
    }
    return taskList;
  }
}

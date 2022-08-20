import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:hive/hive.dart';

import 'task_api.dart';

class LocalStorageApi implements TaskApi {
  @override
  Future<Task> createTask({required Task task, int? revision}) async {
    final box = await Hive.openBox<List<Task>>('tasks');
    final tasklist = box.get('tasks');
    if (tasklist != null) {
      tasklist.add(task);
      box.put('tasks', tasklist);
    }
    await box.close();
    return task;
  }

  @override
  Future<Task> deleteTask({required String id, int? revision}) async {
    final box = await Hive.openBox<List<Task>>('tasks');
    final tasklist = box.get('tasks');
    Task task=  Task(text: '',done: false,importance: Priority.basic, id: id);
    if (tasklist != null) {
      for (int i = 0; i < tasklist.length; i++) {
        if (tasklist[i].id == id) {
          task = tasklist[i];
          tasklist.removeAt(i);
          break;
        }
      }
      box.put('tasks', tasklist);
    }
    await box.close();
    return task;
  }

  @override
  Future<Task> editTask({required Task task, int? revision}) async {
    final box = await Hive.openBox<List<Task>>('tasks');
    final tasklist = box.get('tasks');
    if (tasklist != null) {
      for (int i = 0; i < tasklist.length; i++) {
        if (tasklist[i].id == task.id) {
          tasklist[i] = task;
          break;
        }
      }
      box.put('tasks', tasklist);
    }
    await box.close();
    return task;
  }

  @override
  Future<List<Task>> getList() async {
    final box = await Hive.openBox<List<Task>>('tasks');
    final tasklist = box.get('tasks');
    await box.close();
    return tasklist ?? [];
  }

  @override
  Future<Task> getTask({required String id, int? revision}) async {
    final box = await Hive.openBox<List<Task>>('tasks');
    final tasklist = box.get('tasks');
    Task task= Task(text: '',done: false,importance: Priority.basic, id: id,);
    if (tasklist != null) {
      for (int i = 0; i < tasklist.length; i++) {
        if(tasklist[i].id==id){
          task=tasklist[i];
          break;
        }
      }
    }
    await box.close();
    return task;
  }

  @override
  Future<List<Task>> updateList(
      {required List<Task> taskList, int? revision}) async {
    final box = await Hive.openBox<List<Task>>('tasks');
    box.put('tasks', taskList);
    await box.close();
    return taskList;
  }
}

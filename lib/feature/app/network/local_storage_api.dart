import 'package:done/feature/app/models/task.dart';
import 'package:done/task_api.dart';
import 'package:hive/hive.dart';

class LocalStorageApi implements TaskApi {
  @override
  Future<Task> createTask({required Task task, int? revision}) async {
    final box = await Hive.openBox('tasks');
    await box.put(task.id, task);
    await box.close();
    return task;
  }

  @override
  Future<Task> deleteTask({required String id, int? revision}) async {
    final box = await Hive.openBox('tasks');
    Task task = await box.get(id);
    await box.delete(id);
    await box.close();
    return task;
  }

  @override
  Future<Task> editTask({required Task task, int? revision}) async {
    final box = await Hive.openBox('tasks');
    await box.put(task.id, task);
    await box.close();
    return task;
  }

  @override
  Future<List<Task>> getList() async {
    final box = await Hive.openBox('tasks');
    List<Task> tasklist = await box.get('tasks');
    await box.close();
    return tasklist;
  }

  @override
  Future<Task> getTask({required String id, int? revision}) async {
    final box = await Hive.openBox('tasks');
    Task task = await box.get(id);
    await box.close();
    return task;
  }

  @override
  Future<List<Task>> updateList(
      {required List<Task> taskList, int? revision}) async {
    final box = await Hive.openBox('tasks');
    List<Task> tasklist = await box.get('tasks');
    await box.close();
    return tasklist;
  }
}

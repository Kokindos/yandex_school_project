import 'package:done/feature/app/models/response/list_response.dart';
import 'package:done/feature/app/models/task.dart';

abstract class TaskApi {
  const TaskApi();

  Future<Task> createTask({required Task task, int? revision});

  Future<List<Task>> getList();

  Future<List<Task>> updateList({required List<Task> taskList, int? revision});

  Future<Task> editTask({required Task task, int? revision});

  Future<Task> deleteTask({int? revision, required String id});

  Future<Task> getTask({int? revision, required String id});
}

import 'package:done/feature/app/models/task.dart';
import 'package:done/task_api.dart';

class LocalStorageApi implements TaskApi{

  @override
  Future<Task> createTask({required Task task, required int revision}) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Task> deleteTask({required int revision, required String id}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> editTask({required Task task, required int revision}) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask({required int revision, required String id}) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> updateList({required List<Task> taskList, int? revision}) {
    // TODO: implement updateList
    throw UnimplementedError();
  }

}
import 'dart:async';
import 'package:done/common/services/revision_pref_service.dart';
import 'package:done/feature/app/models/response/list_response.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_repository.dart';
import '../task_api/network_task_backend.dart';

class TaskNetworkRepository implements TaskRepository {
  TaskNetworkRepository(this._networkTaskBackend);

  final RevisionPrefService sharedPrefService = RevisionPrefService();

  final NetworkTaskBackend _networkTaskBackend;

  Future<ListResponse> getRevision() async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return response;
  }

  @override
  Future<List<Task>> getList() async {
    return _networkTaskBackend.getList();
  }

  @override
  Future<Task> createTask({required Task task}) async {
    final tasklist = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: tasklist.revision);
    return _networkTaskBackend.createTask(
        task: task, revision: tasklist.revision);
  }

  @override
  Future<Task> deleteTask({required String id}) async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return _networkTaskBackend.deleteTask(revision: response.revision, id: id);
  }

  @override
  Future<Task> editTask({required Task task}) async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return _networkTaskBackend.editTask(
        task: task, revision: response.revision);
  }

  @override
  Future<Task> getTask({required String id}) async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return _networkTaskBackend.getTask(revision: response.revision, id: id);
  }

  Future<List<Task>> updateList(
      {required List<Task> taskList, required int revision}) async {
    sharedPrefService.saveRevision(revision: revision);
    return _networkTaskBackend.updateList(
        taskList: taskList, revision: revision);
  }
}

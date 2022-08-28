import 'dart:developer';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:done/common/services/revision_pref_service.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_local_repository.dart';
import 'package:done/feature/app/repositories/task_network_repository.dart';
import 'package:done/feature/app/repositories/task_repository.dart';

class TaskConnectRepository implements TaskRepository {
  TaskConnectRepository(
      {required this.taskLocalRepository, required this.taskNetworkRepository});

  final TaskLocalRepository taskLocalRepository;
  final TaskNetworkRepository taskNetworkRepository;
  final RevisionPrefService sharedPrefService = RevisionPrefService();

  @override
  Future<Task> createTask({required Task task}) {
    AppMetrica.reportEvent('Create task event');
    taskNetworkRepository.createTask(task: task);
    return taskLocalRepository.createTask(task: task);
  }

  @override
  Future<Task> deleteTask({required String id}) {
    AppMetrica.reportEvent('Delete task event');
    taskNetworkRepository.deleteTask(id: id);
    return taskLocalRepository.deleteTask(id: id);
  }

  @override
  Future<Task> getTask({required String id}) {
    try {
      return taskNetworkRepository.getTask(id: id);
    } catch (e) {
      return taskLocalRepository.getTask(id: id);
    }
  }

  @override
  Future<Task> editTask({required Task task}) {
    AppMetrica.reportEvent('Edit task event');
    taskNetworkRepository.editTask(task: task);
    return taskLocalRepository.editTask(task: task);
  }

  @override
  Future<List<Task>> getList() async {
    AppMetrica.reportEvent('Get list event');
    int localRevision = await sharedPrefService.getRevision();
    final localResponse = await taskLocalRepository.getList();
    try {
      final removeResponse = await taskNetworkRepository.getRevision();
      log('NETWORK REVISION ${removeResponse.revision}');
      if (localRevision < removeResponse.revision) {
        taskLocalRepository.updateList(taskList: removeResponse.list);
        return removeResponse.list;
      } else {
        taskNetworkRepository.updateList(
            taskList: localResponse, revision: removeResponse.revision);
        return localResponse;
      }
    } catch (e) {
      return localResponse;
    }
  }
}

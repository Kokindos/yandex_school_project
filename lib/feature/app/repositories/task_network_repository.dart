import 'dart:async';
import 'package:done/common/services/shared_pref_service.dart';
import 'package:done/feature/app/models/response/list_response.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/network/network_task_backend.dart';
import 'package:done/feature/app/repositories/task_repository.dart';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class TaskNetworkRepository implements TaskRepository {
  TaskNetworkRepository(this._networkTaskBackend);

  final SharedPrefService sharedPrefService = SharedPrefService();

  final NetworkTaskBackend _networkTaskBackend;

  // final _taskListStreamController = StreamController<List<Task>>();
  // Stream<List<Task>> get taskListStream => _taskListStreamController.stream;

  Future<ListResponse> getRevision() async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return response;
  }

  @override
  Future<List<Task>> getList() async {
    return _networkTaskBackend.getList();
    // try {
    //   final response = await _networkTaskBackend.getList();
    //   //_taskListStreamController.add(response);
    // } catch (e) {
    //   showSimpleNotification(
    //     const Text('Неизвестная ошибка'),
    //     background: AppTheme.red,
    //     position: NotificationPosition.bottom,
    //   );
    // }
  }

  @override
  Future<Task> createTask({required Task task}) async {
    final tasklist = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: tasklist.revision);
    return _networkTaskBackend.createTask(
        task: task, revision: tasklist.revision);
    // try {
    //   final tasklist = await _networkTaskBackend.getRevision();
    //   final createdtask = await _networkTaskBackend.createTask(
    //       task: task, revision: tasklist.revision);
    //
    //  //_taskListStreamController.add(
    //     //    //tasklist.list.toList()..add(createdtask),
    //   //);
    // } on DioError catch (_) {
    //   showSimpleNotification(
    //     const Text('Ошибка: информация не сохранена'),
    //     background: AppTheme.red,
    //     position: NotificationPosition.bottom,
    //   );
    // } catch (_) {
    //   showSimpleNotification(
    //     const Text('Неизвестная ошибка'),
    //     background: AppTheme.red,
    //     position: NotificationPosition.bottom,
    //   );
    // }
  }

  @override
  Future<Task> deleteTask({required String id}) async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return _networkTaskBackend.deleteTask(revision: response.revision, id: id);
  }

  //   try {
  //     final response = await _networkTaskBackend.getRevision();
  //     _networkTaskBackend.deleteTask(revision: response.revision, id: id);
  //     List<Task> tasklist=response.list.toList();
  //     tasklist.removeWhere((element) => element.id==id);
  //     //_taskListStreamController.add(tasklist);
  //   } on DioError catch (_) {
  //     showSimpleNotification(
  //       const Text('Ошибка удаления задачи'),
  //       background: AppTheme.red,
  //       position: NotificationPosition.bottom,
  //     );
  //   } catch (_) {
  //     showSimpleNotification(
  //       const Text('Неизвестная ошибка'),
  //       background: AppTheme.red,
  //       position: NotificationPosition.bottom,
  //     );
  //   }
  // }

  @override
  Future<Task> editTask({required Task task}) async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return _networkTaskBackend.editTask(
        task: task, revision: response.revision);
    // try {
    //   final response = await _networkTaskBackend.getRevision();
    //   _networkTaskBackend.editTask(task: task, revision: response.revision);
    //   List<Task> tasklist=response.list.toList();
    //   for (int i = 0; i < tasklist.length; i++) {
    //     if (tasklist[i].id == task.id) {
    //       tasklist[i] = task;
    //       break;
    //     }
    //   }
    //   //_taskListStreamController.add(tasklist);
    //
    // } on DioError catch (_) {
    //   showSimpleNotification(
    //     const Text('Невозможно обновить задачу'),
    //     background: AppTheme.red,
    //     position: NotificationPosition.bottom,
    //   );
    // } catch (_) {
    //   showSimpleNotification(
    //     const Text('Неизвестная ошибка'),
    //     background: AppTheme.red,
    //     position: NotificationPosition.bottom,
    //   );
    // }
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

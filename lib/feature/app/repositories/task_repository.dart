import 'dart:async';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/network/network_task_backend.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:done/assets/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';



class TaskRepository {
  TaskRepository(this._networkTaskBackend);
  final NetworkTaskBackend _networkTaskBackend;

  final _taskListStreamController = StreamController<List<Task>>();
  Stream<List<Task>> get taskListStream => _taskListStreamController.stream;

  Future<void> getTasks() async {
    try {
      final response = await _networkTaskBackend.getList();
      _taskListStreamController.add(response.list);
    } catch (e) {
      showSimpleNotification(
         const Text('Неизвестная ошибка'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    }
  }

  void createTask({required Task task}) async {
    try {
      final tasklist = await _networkTaskBackend.getList();
      final createdtask = await _networkTaskBackend.createTask(
          task: task, revision: tasklist.revision);

     _taskListStreamController.add(
       tasklist.list.toList()..add(createdtask.element),
      );
    } on DioError catch (_) {
      showSimpleNotification(
        const Text('Ошибка: информация не сохранена'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    } catch (_) {
      showSimpleNotification(
        const Text('Неизвестная ошибка'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    }
  }

  void deleteTask({required String id}) async {
    try {
      final response = await _networkTaskBackend.getList();
      _networkTaskBackend.deleteTask(revision: response.revision, id: id);
      List<Task> tasklist=response.list.toList();
      tasklist.removeWhere((element) => element.id==id);
      _taskListStreamController.add(tasklist);
    } on DioError catch (_) {
      showSimpleNotification(
        const Text('Ошибка удаления задачи'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    } catch (_) {
      showSimpleNotification(
        const Text('Неизвестная ошибка'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    }
  }


  void editTask({required Task task}) async {
    try {
      final response = await _networkTaskBackend.getList();
      _networkTaskBackend.editTask(task: task, revision: response.revision);
      List<Task> tasklist=response.list.toList();
      for (int i = 0; i < tasklist.length; i++) {
        if (tasklist[i].id == task.id) {
          tasklist[i] = task;
          break;
        }
      }
      _taskListStreamController.add(tasklist);

    } on DioError catch (_) {
      showSimpleNotification(
        const Text('Невозможно обновить задачу'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    } catch (_) {
      showSimpleNotification(
        const Text('Неизвестная ошибка'),
        background: AppTheme.red,
        position: NotificationPosition.bottom,
      );
    }
  }
}

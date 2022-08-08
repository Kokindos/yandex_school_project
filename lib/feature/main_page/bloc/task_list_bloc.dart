import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/main_page/bloc/task_list_state.dart';
import 'package:done/feature/app/repositories/task_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class TaskListBloc extends Cubit<TaskListState> {
  TaskListBloc(this._taskRepository)
      : super(const TaskListState.loading(showDoneTasks: true)) {
    subscribeToTaskList();
    getTasks();
  }

  final TaskRepository _taskRepository;

  StreamSubscription<List<Task>>? _taskListSubscription;

  @override
  Future<void> close() {
    _taskListSubscription?.cancel();
    return super.close();
  }

  void subscribeToTaskList() {
    _taskListSubscription = _taskRepository.taskListStream.listen((tasks) {
      emit(
        TaskListState.loaded(
          tasks: tasks,
          visibledTasks: tasks.where((task) => !task.done).toList(),
          doneTasksCounter: tasks.where((task) => task.done).length,
          showDoneTasks: state.showDoneTasks,
        ),
      );
    });
  }

  void switchListVisibility() {
    emit(state.copyWith(showDoneTasks: !state.showDoneTasks));
  }

  Future<void> getTasks() async {
    emit(TaskListState.loading(showDoneTasks: state.showDoneTasks));
    try {
      await _taskRepository.getTasks();
    } catch (e) {
      emit(
        TaskListState.error(
          message: e.toString(),
          showDoneTasks: state.showDoneTasks,
        ),
      );
    }
  }

  void setDoneTask(Task task) async {
    task = task.copyWith(
      done: !task.done,
    );
    editTask(task);
  }

  void editTask(Task task) async {
    try {
      task = task.copyWith(
        changedAt: DateTime.now().microsecondsSinceEpoch,
        lastUpdatedBy: await getDeviceInfo(),
      );
      _taskRepository.editTask(task: task);
    } catch (e) {
      emit(
        TaskListState.error(
          message: e.toString(),
          showDoneTasks: state.showDoneTasks,
        ),
      );
    }
  }

  void createQuickTask({required TextEditingController textController}) async {
    Task task = Task(
      id: const Uuid().v1(),
      text: textController.text,
      done: false,
      importance: Priority.basic,
      changedAt: DateTime.now().microsecondsSinceEpoch,
      createdAt: DateTime.now().microsecondsSinceEpoch,
      lastUpdatedBy: await getDeviceInfo(),
    );
    _taskRepository.createTask(task: task);
    textController.clear();
  }

  void deleteTask(Task task) {
    _taskRepository.deleteTask(id: task.id);
  }

  Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      const deviceType = 'ANDROID';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final deviceName = androidInfo.model ?? '';
      return '$deviceType $deviceName';
    } else if (Platform.isIOS) {
      const deviceType = 'IOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final deviceName = iosInfo.model ?? '';
      return '$deviceType $deviceName';
    }
  }
}

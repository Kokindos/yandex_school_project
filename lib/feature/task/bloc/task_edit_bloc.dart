import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/task/bloc/task_edit_state.dart';
import 'package:done/feature/app/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class TaskEditBloc extends Cubit<TaskEditState> {
  TaskEditBloc(
    this._taskRepository, {
    Task? task,
  }) : super(
          TaskEditState.task(
            importance: Priority.basic,
            textController: TextEditingController(),
          ),
        ) {
    if (task != null) {
      emit(
        TaskEditState.editingTask(
          editingTask: task,
          textController: TextEditingController(text: task.text),
          importance: task.importance,
          deadline: task.deadline,
        ),
      );
    }
  }

  final TaskRepository _taskRepository;

  void saveTask() async{
    if (state is TaskEditStateInitial) {
      _taskRepository.createTask(
        task: Task(
          id: const Uuid().v1(),
          text: state.textController.text,
          done: false,
          importance: state.importance,
          deadline: state.deadline,
          changedAt: DateTime.now().microsecondsSinceEpoch,
          createdAt: DateTime.now().microsecondsSinceEpoch,
          lastUpdatedBy: await getDeviceInfo(),
        ),
      );
    } else if (state is TaskEditStateLoading) {
      _taskRepository.editTask(
        task: Task(
          id: (state as TaskEditStateLoading).editingTask.id,
          text: state.textController.text,
          done: (state as TaskEditStateLoading).editingTask.done,
          importance: state.importance,
          deadline: state.deadline,
          changedAt: DateTime.now().microsecondsSinceEpoch,
          createdAt: (state as TaskEditStateLoading).editingTask.createdAt,
          lastUpdatedBy:  await getDeviceInfo(),
        ),
      );
    }
  }

  void deleteTask() {
    if (state is TaskEditStateLoading) {
      _taskRepository.deleteTask(
        id: (state as TaskEditStateLoading).editingTask.id,
      );
    }
  }

  void changePriority(Priority importance) {
    emit(
      state.copyWith(importance: importance),
    );
  }

  void changeDeadline(DateTime? deadline) {
    emit(
      state.copyWith(deadline: deadline?.microsecondsSinceEpoch),
    );
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

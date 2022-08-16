import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../app/repositories/task_connect_repository.dart';

part 'tasklist_event.dart';

part 'tasklist_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskConnectRepository _taskRepository;

  TaskListBloc({
    required TaskConnectRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(TaskListInitial()) {
    _taskRepository.getList();
    on<DeleteTaskEvent>((event, emit) async {
      try {
        await _taskRepository.deleteTask(id: event.task.id);
        final currentState = state as TaskListLoadedState;
        currentState.tasks.remove(event.task);
        final newDoneTaskCounter =
            currentState.tasks.where((task) => task.done).length;
        emit(TaskListLoadedState(
          tasks: currentState.tasks,
          doneTasksCounter: newDoneTaskCounter,
          showDoneTasks: currentState.showDoneTasks,
        ));
      } catch (e) {
        emit(
          TaskListErrorState(
            e.toString(),
          ),
        );
      }
    });
    on<EditTaskEvent>((event, emit) async {
      final currentState = state as TaskListLoadedState;
      try {
        final task = event.task.copyWith(
          changedAt: DateTime.now().microsecondsSinceEpoch,
          lastUpdatedBy: await getDeviceInfo(),
        );
        await _taskRepository.editTask(task: task);
        for (int i = 0; i <= currentState.tasks.length; i++) {
          if (currentState.tasks[i].id == task.id) {
            currentState.tasks[i] = task;
            break;
          }
        }
        int newDoneTasksCounter = task.done == true
            ? currentState.doneTasksCounter + 1
            : currentState.doneTasksCounter;
        emit(TaskListLoadedState(
            tasks: currentState.tasks,
            doneTasksCounter: newDoneTasksCounter,
            showDoneTasks: currentState.showDoneTasks));
      } catch (e) {
        emit(
          TaskListErrorState(
            e.toString(),
          ),
        );
      }
    });
    on<CreateTaskEvent>((event, emit) async {
      Task task = Task(
        id: const Uuid().v1(),
        text: event.textController.text,
        done: false,
        importance: Priority.basic,
        changedAt: DateTime.now().microsecondsSinceEpoch,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        lastUpdatedBy: await getDeviceInfo(),
      );
      await _taskRepository.createTask(task: task);
      final currentState = state as TaskListLoadedState;
      currentState.tasks.add(task);
      event.textController.clear();
      emit(TaskListLoadedState(
          tasks: currentState.tasks,
          doneTasksCounter: currentState.doneTasksCounter,
          showDoneTasks: currentState.showDoneTasks));
    });
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

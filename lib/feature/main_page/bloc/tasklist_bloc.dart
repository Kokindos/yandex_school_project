import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_connect_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../../app/repositories/task_network_repository.dart';

part 'tasklist_event.dart';

part 'tasklist_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  //final TaskConnectRepository _taskRepository;
  final TaskNetworkRepository _taskRepository;

  TaskListBloc({
    required TaskNetworkRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(TaskListLoadingState()) {
    on<GetListEvent>(_onGetList);
    on<DeleteTaskEvent>(_onDelete);
    on<CreateTaskEvent>(_onCreate);
    on<EditTaskEvent>(_onEdit);
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

  Future<void> _onEdit(EditTaskEvent event, Emitter<TaskListState> emit) async {
    log(event.task.toString());
    try {
      final task = event.task.copyWith(
        changedAt: DateTime.now().microsecondsSinceEpoch,
        lastUpdatedBy: await getDeviceInfo(),
      );
      await _taskRepository.editTask(task: task);
      final _state = state;
      if (_state is TaskListLoadedState) {
        for (int i = 0; i < _state.tasks.length; i++) {
          if (_state.tasks[i].id == event.task.id) {
            _state.tasks[i] = task;
            break;
          }
        }
        emit(
          TaskListLoadedState(
            tasks: _state.tasks,
          ),
        );
      }
    } catch (e) {
      emit(
        TaskListErrorState(
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> _onCreate(
      CreateTaskEvent event, Emitter<TaskListState> emit) async {
    Task task = Task(
      id: const Uuid().v1(),
      text: event.text,
      done: false,
      importance: event.importance ?? Priority.basic,
      deadline: event.deadline,
      changedAt: DateTime.now().microsecondsSinceEpoch,
      createdAt: DateTime.now().microsecondsSinceEpoch,
      lastUpdatedBy: await getDeviceInfo(),
    );
    try {
      await _taskRepository.createTask(task: task);
      final _state = state;
      if (_state is TaskListLoadedState) {
        _state.tasks.add(task);

        emit(
          TaskListLoadedState(
            tasks: _state.tasks,
          ),
        );
      }
    } catch (e) {
      emit(
        TaskListErrorState(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _onDelete(
      DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    try {
      await _taskRepository.deleteTask(id: event.task.id);
      final _state = state;
      if (_state is TaskListLoadedState) {
        _state.tasks.remove(event.task);

        emit(
          TaskListLoadedState(
            tasks: _state.tasks,
          ),
        );
      }
    } catch (e) {
      emit(
        TaskListErrorState(
          e.toString(),
        ),
      );

    }
  }

  Future<void> _onGetList(
      GetListEvent event, Emitter<TaskListState> emit) async {
    emit(TaskListLoadingState());
    try {
      final response = await _taskRepository.getList();
      emit(TaskListLoadedState(tasks: response));
    } catch (e) {
      log(e.toString());
      emit(TaskListErrorState(e.toString()));
      rethrow;
    }
  }
}

import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_edit_state.freezed.dart';

@freezed
class TaskEditState with _$TaskEditState {
  const factory TaskEditState.task({
    required TextEditingController textController,
    required Priority importance,
    int? deadline,
  }) = TaskEditStateInitial;

  const factory TaskEditState.editingTask({
    required Task editingTask,
    required TextEditingController textController,
    required Priority importance,
    int? deadline,
  }) = TaskEditStateLoading;
}

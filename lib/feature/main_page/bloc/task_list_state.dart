import 'package:done/feature/app/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_list_state.freezed.dart';

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.loaded({
    required List<Task> tasks,
    required List<Task> visibledTasks,
    required int doneTasksCounter,
    required bool showDoneTasks,
  }) = TaskListStateInitial;

  const factory TaskListState.loading({
    required bool showDoneTasks,
  }) = TaskListStateLoading;

  const factory TaskListState.error({
    required String message,
    required bool showDoneTasks,
  }) = TaskListStateError;
}

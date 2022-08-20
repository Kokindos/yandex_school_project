part of 'tasklist_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListLoadedState extends TaskListState {
  final List<Task> tasks;

  TaskListLoadedState({
    required this.tasks,
  });
}

class TaskListLoadingState extends TaskListState {}

class TaskListErrorState extends TaskListState {
  final String message;

  TaskListErrorState(this.message);
}

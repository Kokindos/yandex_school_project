part of 'tasklist_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {
  TaskListInitial();
}

class TaskListLoadedState extends TaskListState {
  final List<Task> tasks;
  final int doneTasksCounter;
  final bool showDoneTasks;

  TaskListLoadedState(
      {required this.tasks,
      required this.doneTasksCounter,
      required this.showDoneTasks});
}

class TaskListLoadingState extends TaskListState {
  TaskListLoadingState();
}

class TaskListErrorState extends TaskListState {
  final String message;

  TaskListErrorState(this.message);
}

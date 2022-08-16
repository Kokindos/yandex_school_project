part of 'tasklist_bloc.dart';

@immutable
abstract class TaskListEvent {}
class DeleteTaskEvent extends TaskListEvent{
  final Task task;
  DeleteTaskEvent(this.task);
}
class EditTaskEvent extends TaskListEvent{
  final Task task;
  EditTaskEvent(this.task);
}
class CreateTaskEvent extends TaskListEvent{
  final TextEditingController textController;
  CreateTaskEvent(this.textController);
}
 part of 'tasklist_bloc.dart';
//
// @immutable
// abstract class TaskListEvent {}
//
// class DeleteTaskEvent extends TaskListEvent {
//   final Task task;
//
//   DeleteTaskEvent(this.task);
// }
//
// class EditTaskEvent extends TaskListEvent {
//   final Task task;
//
//   EditTaskEvent(this.task);
// }
//
// class CreateTaskEvent extends TaskListEvent {
//   final Priority? importance;
//   final int? deadline;
//   final String text;
//
//   CreateTaskEvent(this.text, {this.importance, this.deadline});
// }
// class GetListEvent extends TaskListEvent{
// }
 @freezed
 class TaskListEvent with _$TaskListEvent{
   const factory TaskListEvent.delete({required Task task})=DeleteTaskEvent;
   const factory TaskListEvent.edit({required Task task})=EditTaskEvent;
   const factory TaskListEvent.create( String text, {Priority? importance,int? deadline})=CreateTaskEvent;
   const factory TaskListEvent.getList()=GetListEvent;
 }
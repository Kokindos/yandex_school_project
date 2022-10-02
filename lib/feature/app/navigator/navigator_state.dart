import 'package:done/feature/app/models/task.dart';

abstract class NavigatorConfigState {}

class NavigatorListState extends NavigatorConfigState {}

class NavigatorTaskState extends NavigatorConfigState {
  final bool isNew;
  final String? id;

  NavigatorTaskState({required this.id, this.isNew = false});
}

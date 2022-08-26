import 'package:done/feature/app/models/task.dart';

abstract class NavigatorConfigState {}

class NavigatorListState extends NavigatorConfigState {}

class NavigatorTaskState extends NavigatorConfigState {
  final String id;

  NavigatorTaskState({required this.id});
}

class NavigatorNewTaskState extends NavigatorConfigState {
}

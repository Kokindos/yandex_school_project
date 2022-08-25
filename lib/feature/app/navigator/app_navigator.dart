import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/navigator/navigation_delegate.dart';
import 'package:done/feature/app/navigator/navigation_information_parser.dart';
import 'package:rxdart/rxdart.dart';

class AppNavigator {
  final NavigationDelegate navigationDelegate;

  final NavigationInformationParser routeInforamtionParser;

  AppNavigator({
    required Task task,
    required BehaviorSubject<List<Task>> tasksStream,
  })  : navigationDelegate = NavigationDelegate(
          task: task,
          tasksStream: tasksStream,
        ),
        routeInforamtionParser = NavigationInformationParser();
}

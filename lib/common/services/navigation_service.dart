import 'package:done/common/routes/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:done/feature/app/models/task.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  NavigationService();

  void onPop() {
    navigationKey.currentState!.pop();
  }

  void onTaskScreen({Task? task}) {
    navigationKey.currentState!.pushNamed(
      AppRouter.taskScreen,
      arguments: RoutersArgument(task: task),
    );
  }

  void onMainScreen() {
    navigationKey.currentState!.pushNamed(AppRouter.mainScreen);
  }
}

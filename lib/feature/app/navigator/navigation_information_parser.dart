import 'dart:developer';

import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/navigator/navigator_state.dart';

import 'package:flutter/material.dart';

class NavigationInformationParser
    extends RouteInformationParser<NavigatorConfigState> {
  @override
  RouteInformation? restoreRouteInformation(
      NavigatorConfigState configuration) {
    if (configuration is NavigatorTaskState) {
      return RouteInformation(location: '/editscreen/${configuration.id}');
    } else if (configuration is NavigatorNewTaskState) {
      return const RouteInformation(location: '/create');
    } else {
      return const RouteInformation(location: '/listscreen');
    }
  }

  @override
  Future<NavigatorConfigState> parseRouteInformation(
      RouteInformation routeInformation) async {
    if (routeInformation.location != null) {
      final url = Uri.parse(routeInformation.location!);
      log(url.pathSegments.toString());
      if (url.pathSegments.isNotEmpty) {
        if (url.pathSegments.first == 'editscreen') {
          if (url.pathSegments.length > 2) {
            if (url.pathSegments[1].isNotEmpty) {
              final id = url.pathSegments[1];
              return NavigatorTaskState(id: id);
            }
            //return NavigatorTaskState(id: url.pathSegments[1]);
          }
        } else if (url.pathSegments.first == 'create') {
          final task = Task.initial();
          return NavigatorNewTaskState();
        }
      }
    }
    return NavigatorListState();
  }
}

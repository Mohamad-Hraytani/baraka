import 'package:flutter/material.dart';

import 'navigation_observer_processor/navigation_observer_processor.dart';

///Note that : in case of clearStackAndShow
///( The first action must be removeLast × 2 then push, but the current procedure is opposite )
///and that is caused a problem
class MyNavigatorObserverUtil extends NavigatorObserver {
  List<Route<dynamic>> _routeStack = [];

  List<Route<dynamic>> get routeStack => _routeStack;

  List<RouteNameModel> get routeStackNames =>
      routeStack.map((e) => RouteNameModel(e.settings.name ?? "")).toList();

  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    routeStack.add(route!);
  }

  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
  }

  @override
  void didRemove(Route? route, Route? previousRoute) {
    routeStack.removeLast();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    routeStack.removeLast();
    routeStack.add(newRoute!);
  }
}

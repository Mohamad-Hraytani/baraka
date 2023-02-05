import '../../../../app/locator.dart';
import '../navigation_observer_util.dart';

class RouteNameModel {
  final String name;

  RouteNameModel(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteNameModel &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class NavigationObserverProcessor {
  static bool isRouteIsExist(String routeName) =>
      locator<MyNavigatorObserverUtil>()
          .routeStackNames
          .contains(RouteNameModel(routeName));

  static List<RouteNameModel> get getRoutesNames =>
      locator<MyNavigatorObserverUtil>().routeStackNames;

  static List<String> get getRoutesNamesAsString =>
      locator<MyNavigatorObserverUtil>()
          .routeStackNames
          .map((e) => e.name)
          .toList();

  static String get getFistRoute =>
      locator<MyNavigatorObserverUtil>().routeStackNames.first.name;

  static String get getLastRoute =>
      locator<MyNavigatorObserverUtil>().routeStackNames.last.name;

  static bool getIsCurrentRoute(String route) =>
      locator<MyNavigatorObserverUtil>().routeStackNames.last.name == route;

  static bool getIsNotCurrentRoute(String route) =>
      locator<MyNavigatorObserverUtil>().routeStackNames.last.name != route;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetbook/routes/routes.dart';

final globalNavigationKey = GlobalKey<NavigatorState>();
final homeAppNavigator = GlobalKey<NavigatorState>();
final goRouter = GoRouter(navigatorKey: globalNavigationKey, routes: [
  ShellRoute(
      navigatorKey: homeAppNavigator,
      builder: (context, state, child) {
        return child;
      },
      routes: Routes.values
          .map((e) => GoRoute(
                path: e.route,
                builder: (context, state) => e.builder(context, state),
              ))
          .toList()),
]);

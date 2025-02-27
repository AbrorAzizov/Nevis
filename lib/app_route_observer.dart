import 'package:flutter/material.dart';
import 'package:nevis/features/presentation/bloc/route_observer/route_observer_bloc.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final RouteObserverBloc routeObserverBloc;

  AppRouteObserver(this.routeObserverBloc);

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      routeObserverBloc.add(RouteChanged(route.settings.name));
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      routeObserverBloc.add(
        RouteChanged(previousRoute.settings.name),
      );
    }
  }
}

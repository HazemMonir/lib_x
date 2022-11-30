// ignore_for_file: constant_identifier_names
import 'package:example/src/src.dart';

// ToDo: declare string paths

final RouteMap routeMap = RouteMap(
  routes: {
    Root: (RouteData info) => const MaterialPage(child: HomePage()),
  },
  onUnknownRoute: (_) => const MaterialPage(child: NotFoundPage()),
);

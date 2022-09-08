import 'package:numerical_methods/ui/widgets/example.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/laba1.dart';

class mainNavigationNameRoute {
  static const main = '/';
  static const laba1 = '/laba1';
}

class MainNavigation {
  final routes = {
    mainNavigationNameRoute.main: (context) => const Example(),
    mainNavigationNameRoute.laba1: (context) => const Laba1(),
  };
  final initialRoute = mainNavigationNameRoute.main;
}
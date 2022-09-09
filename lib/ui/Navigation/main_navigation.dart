import 'package:numerical_methods/ui/widgets/example.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/lab1_widget.dart';

class mainNavigationNameRoute {
  static const main = '/';
  static const lab1 = '/lab1';
}

class MainNavigation {
  final routes = {
    mainNavigationNameRoute.main: (context) => const Example(),
    mainNavigationNameRoute.lab1: (context) => const Lab1Widget(),
  };
  final initialRoute = mainNavigationNameRoute.main;
}
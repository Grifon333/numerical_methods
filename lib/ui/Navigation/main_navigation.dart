import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab2/lab2_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab2/lab2_widget.dart';
import 'package:numerical_methods/ui/widgets/mainScreen.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/lab1_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/lab1_model.dart';

class MainNavigationNameRoute {
  static const main = '/';
  static const lab1 = '/lab1';
  static const lab2 = '/lab2';
}

class MainNavigation {
  final routes = {
    MainNavigationNameRoute.main: (context) => const Example(),
    MainNavigationNameRoute.lab1: (context) => NotifierProvider(
          create: () => Lab1Model(),
          child: const Lab1Widget(),
        ),
    MainNavigationNameRoute.lab2: (context) => NotifierProvider(
          child: const Lab2Widget(),
          create: () => Lab2Model(),
        ),
  };
  final initialRoute = MainNavigationNameRoute.main;
}

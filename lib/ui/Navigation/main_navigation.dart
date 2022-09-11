import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/example.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/lab1_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/list_operations/lab1_model.dart';

class mainNavigationNameRoute {
  static const main = '/';
  static const lab1 = '/lab1';
}

class MainNavigation {
  final routes = {
    mainNavigationNameRoute.main: (context) => const Example(),
    mainNavigationNameRoute.lab1: (context) => NotifierProvider(
          create: () => Lab1Model(),
          child: const Lab1Widget(),
        ),
  };
  final initialRoute = mainNavigationNameRoute.main;
}

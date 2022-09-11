import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/example.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/lab1_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/list_operations/prod_vec_and_scalar/prod_vec_scal_model.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/list_operations/prod_vec_and_scalar/prod_vec_scal_widget.dart';

class mainNavigationNameRoute {
  static const main = '/';
  static const lab1 = '/lab1';
  static const lab1_1 = '/lab1/1';
}

class MainNavigation {
  final routes = {
    mainNavigationNameRoute.main: (context) => const Example(),
    mainNavigationNameRoute.lab1: (context) => const Lab1Widget(),
    mainNavigationNameRoute.lab1_1: (context) => NotifierProvider(
          create: () => ProdVecScalModel(),
          child: const ProdVecScalWidget(),
        ),
  };
  final initialRoute = mainNavigationNameRoute.main;
}

import 'package:flutter/material.dart';
import 'package:numerical_methods/Theme/app_colors.dart';
import 'package:numerical_methods/ui/Navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final navigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.main,
        ),
      ),
      initialRoute: navigation.initialRoute,
      routes: navigation.routes,
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numerical_methods/Theme/app_colors.dart';

class Lab5Model extends ChangeNotifier {
  double a = 1.4;
  double b = 3;
  int n = 2;
  double accurate = 0.001;
  double? result;
  bool isShow = false;
  Color btn1 = AppColors.main;
  Color btn2 = AppColors.main;
  Color btn3 = AppColors.main;
  Color btn4 = AppColors.main;

  double formula(double x) {
    return x * x * (log(x) / ln10);
  }

  void leftRectanglesMethod() {
    n = 2;
    double h = (b - a) / n;
    while (h > accurate) {
      n *= 2;
      h = (b - a) / n;
    }
    result = round(_calculateSum(h, formula(a)));
    isShow = true;
    btn1 = Colors.lightGreen;
    btn2 = AppColors.main;
    btn3 = AppColors.main;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void rightRectanglesMethod() {
    n = 2;
    double h = (b - a) / n;
    while (h > accurate) {
      n *= 2;
      h = (b - a) / n;
    }
    result = round(_calculateSum(h, formula(b)));
    isShow = true;
    btn1 = AppColors.main;
    btn2 = Colors.lightGreen;
    btn3 = AppColors.main;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void trapezeMethod() {
    n = 2;
    double h = (b - a) / n;
    while (h * h > accurate) {
      n *= 2;
      h = (b - a) / n;
    }
    result = round(_calculateSum(h, (formula(a) + formula(b)) / 2));
    isShow = true;
    btn1 = AppColors.main;
    btn2 = AppColors.main;
    btn3 = Colors.lightGreen;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void simpsonsMethod() {
    n = 2;
    double h = (b - a) / n;
    while (h * h * h * h > accurate) {
      n *= 2;
      h = (b - a) / n;
    }
    n *= 16;
    h = (b - a) / n;
    result = round(_simpson(h));
    isShow = true;
    btn1 = AppColors.main;
    btn2 = AppColors.main;
    btn3 = AppColors.main;
    btn4 = Colors.lightGreen;
    notifyListeners();
  }

  double _calculateSum(double h, double sum) {
    double h = (b - a) / 2;
    for (int i = 1; i < n - 1; i++) {
      sum += formula(a + i * h);
    }
    return sum * h;
  }

  double _simpson(double h) {
    double sum = formula(a) + formula(b);
    int k;
    for (int i = 0; i <= n - 1; i++) {
      k = 2 + 2 * (i % 2);
      sum += k * formula(a + i * h);
    }
    sum /= 3;
    return sum * h;
  }

  double round(double value) {
    return (value * 1000).roundToDouble() / 1000;
  }
}

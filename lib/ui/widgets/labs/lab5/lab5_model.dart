import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numerical_methods/Theme/app_colors.dart';

class Lab5Model extends ChangeNotifier {
  double a = 1.4;
  double b = 3;
  int n = 2;
  double accurate = 0.001;
  List<String> result = [];
  bool isShow = false;
  Color btn1 = AppColors.main;
  Color btn2 = AppColors.main;
  Color btn3 = AppColors.main;
  Color btn4 = AppColors.main;

  double formula(double x) {
    return x * x * (log(x) / ln10);
  }

  void leftRectanglesMethod() {
    result.clear();
    n = 2;
    double integralOne = _calculateSum(formula(a));
    double integralTwo;
    double dif;
    result.add('n = $n;   I = ${round(integralOne)}');
    do {
      n *= 2;
      integralTwo = _calculateSum(formula(a));
      dif = module(integralTwo - integralOne);
      integralOne = integralTwo;
      result.add('n = $n;   I = ${round(integralOne)}');
    } while (dif > 3 * accurate);

    isShow = true;
    btn1 = Colors.lightGreen;
    btn2 = AppColors.main;
    btn3 = AppColors.main;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void rightRectanglesMethod() {
    result.clear();
    n = 2;
    double integralOne = _calculateSum(formula(b));
    double integralTwo;
    double dif;
    result.add('n = $n;   I = ${round(integralOne)}');
    do {
      n *= 2;
      integralTwo = _calculateSum(formula(b));
      dif = module(integralTwo - integralOne);
      integralOne = integralTwo;
      result.add('n = $n;   I = ${round(integralOne)}');
    } while (dif > 3 * accurate);

    isShow = true;
    btn1 = AppColors.main;
    btn2 = Colors.lightGreen;
    btn3 = AppColors.main;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void trapezeMethod() {
    result.clear();
    n = 2;
    double integralOne = _calculateSum((formula(a) + formula(b)) / 2);
    double integralTwo;
    double dif;
    result.add('n = $n;   I = ${round(integralOne)}');
    do {
      n *= 2;
      integralTwo = _calculateSum((formula(a) + formula(b)) / 2);
      dif = module(integralTwo - integralOne);
      integralOne = integralTwo;
      result.add('n = $n;   I = ${round(integralOne)}');
    } while (dif > 3 * accurate);

    isShow = true;
    btn1 = AppColors.main;
    btn2 = AppColors.main;
    btn3 = Colors.lightGreen;
    btn4 = AppColors.main;
    notifyListeners();
  }

  void simpsonsMethod() {
    result.clear();
    n = 2;
    double integralOne = _simpson();
    double integralTwo;
    double dif;
    result.add('n = $n;   I = ${round(integralOne)}');
    do {
      n *= 2;
      integralTwo = _simpson();
      dif = module(integralTwo - integralOne);
      integralOne = integralTwo;
      result.add('n = $n;   I = ${round(integralOne)}');
    } while (dif > 15 * accurate);

    isShow = true;
    btn1 = AppColors.main;
    btn2 = AppColors.main;
    btn3 = AppColors.main;
    btn4 = Colors.lightGreen;
    notifyListeners();
  }

  double _calculateSum(double sum) {
    double h = (b - a) / n;
    for (int i = 1; i < n - 1; i++) {
      sum += formula(a + i * h);
    }
    return sum * h;
  }

  double _simpson() {
    double h = (b - a) / n;
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
    return (value * 100000).roundToDouble() / 100000;
  }

  double module(double value) {
    if (value < 0) {
      return value * -1;
    }
    return value;
  }

  String getResult() {
    return result.join('\n');
  }
}

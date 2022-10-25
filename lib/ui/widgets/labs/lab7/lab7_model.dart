import 'dart:math';

import 'package:flutter/cupertino.dart';

class Lab7Model extends ChangeNotifier {
  final n = 5;
  final a = 0.0;
  final b = 10.0;
  final h = 0.5;
  late List<double> xNodes;
  late List<double> yNodes;
  late List<double> x;
  late List<double> yIteration;
  late List<double> yReal;
  late List<double> delta;
  bool isShow = false;

  void _initialization() {
    xNodes = List.filled(n, 0.0);
    yNodes = List.filled(n, 0.0);

    int size = ((b - a) / h + 1).toInt();
    x = List.filled(size, 0.0);
    yIteration = List.filled(size, 0.0);
    yReal = List.filled(size, 0.0);
    delta = List.filled(size, 0.0);
  }

  void interpolation() {
    _initialization();
    _fillCoordinates();
    int count = 0;

    for (double z = a; z <= b; z += h) {
      double result = 0;
      for (int i = 0; i < n; i++) {
        double p = 1;
        for (int j = 0; j < n; j++) {
          if (j != i) {
            p *= (z - xNodes[j]) / (xNodes[i] - xNodes[j]);
          }
        }
        result += yNodes[i] * p;
      }

      double y = formula(z);
      double d = max(y, result) - min(y, result);
      x[count] = z;
      yIteration[count] = result;
      yReal[count] = y;
      delta[count] = d;

      count++;
    }

    isShow = true;
    notifyListeners();
  }

  void _fillCoordinates() {
    for (int i = 0; i < n; i++) {
      xNodes[i] = a + i * (b - a) / (n - 1);
      yNodes[i] = formula(xNodes[i]);
    }
  }

  double formula(double x) {
    return log(x + 1);
  }

  double round(double num) {
    return (num * 1000).roundToDouble() / 1000;
  }

  String getX() {
    return x.join('\n');
  }

  String getYIteration() {
    return yIteration.map((e) => round(e)).join('\n');
  }

  String getYReal() {
    return yReal.map((e) => round(e)).join('\n');
  }

  String getDelta() {
    return delta.map((e) => round(e)).join('\n');
  }
}

import 'package:flutter/cupertino.dart';

class Lab8Model extends ChangeNotifier {
  List<double> x = [];
  List<double> y = [];
  List<double> g = [];
  int n = 0;
  double a1 = 0;
  double a2 = 0;
  List<Offset> points = [];
  bool isShow = false;

  void _initialization() {
    n = 9;
    x = [1.2, 2.3, 3.8, 4.3, 5.4, 6.3, 7.5, 8.1, 9.6];
    y = [1.04, 1.16, 1.48, 1.76, 2.16, 2.67, 3.83, 4.72, 6.56];
    for (int i = 0; i < n; i++) {
      points.add(Offset(x[i], y[i]));
    }
    g = List.filled(n, 0.0);
  }

  void methodSquareRoot() {
    _initialization();

    for (int i = 0; i < n; i++) {
      g[i] = 1 / y[i];
    }
    double s1 = 0, s2 = 0, s10 = 0, s11 = 0;

    for (int i = 0; i < n; i++) {
      s1 += x[i];
      s2 += x[i] * x[i];
      s10 += g[i];
      s11 += x[i] * g[i];
    }

    a2 = (n * s11 - s1 * s10) / (n * s2 - s1 * s1);
    a1 = (s10 - a2 * s1) / n;

    isShow = true;
    notifyListeners();
  }

  double formula(double x) {
    return 1 / (a1 + a2 * x);
  }

  double round(double num) {
    return (num * 1000).roundToDouble() / 1000;
  }

  double getA1() {
    return round(a1);
  }

  double getA2() {
    return round(a2);
  }
}

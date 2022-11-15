import 'dart:math';

import 'package:flutter/cupertino.dart';

class Lab8Model extends ChangeNotifier {
  List<double> x = [];
  List<double> y = [];
  int n = 0;
  List<double> k_1 = [];
  List<double> k_2 = [];
  List<double> k_3 = [];
  List<double> g_1 = [];
  List<double> g_2 = [];
  List<double> g_3 = [];
  double _a1_1 = 0;
  double _a2_1 = 0;
  double _a1_2 = 0;
  double _a2_2 = 0;
  double _a1_3 = 0;
  double _a2_3 = 0;
  double _uncertainty1 = 0;
  double _uncertainty2 = 0;
  double _uncertainty3 = 0;
  List<Offset> points = [];
  bool isShow = false;

  void _initialization() {
    n = 9;
    x = [1.2, 2.3, 3.8, 4.3, 5.4, 6.3, 7.5, 8.1, 9.6];
    y = [1.04, 1.16, 1.48, 1.76, 2.16, 2.67, 3.83, 4.72, 6.56];

    for (int i = 0; i < n; i++) {
      points.add(Offset(x[i], y[i]));
    }
    k_1 = List.filled(n, 0.0);
    k_2 = List.filled(n, 0.0);
    k_3 = List.filled(n, 0.0);
    g_1 = List.filled(n, 0.0);
    g_2 = List.filled(n, 0.0);
    g_3 = List.filled(n, 0.0);
    _uncertainty1 = 0;
    _uncertainty2 = 0;
    _uncertainty3 = 0;
  }

  void methodSquareRoot() {
    _initialization();

    for (int i = 0; i < n; i++) {
      k_1[i] = x[i];
      g_1[i] = 1 / y[i];

      k_2[i] = x[i];
      g_2[i] = log(y[i]);

      k_3[i] = x[i];
      g_3[i] = y[i];
    }
    List<double> res = calculateA1andA2(k_1, g_1);
    _a1_1 = res[0];
    _a2_1 = res[1];
    for (int i = 0; i < n; i++) {
      double dif = y[i] - formula1(x[i]);
      _uncertainty1 += dif * dif;
    }
    print(_uncertainty1);

    res = calculateA1andA2(k_2, g_2);
    double a1 = res[0];
    double a2 = res[1];
    _a1_2 = pow(e, a1).toDouble();
    _a2_2 = a2;
    for (int i = 0; i < n; i++) {
      double dif = y[i] - formula2(x[i]);
      _uncertainty2 += dif * dif;
    }
    print(_uncertainty2);

    res = calculateA1andA2(k_3, g_3);
    _a1_3 = res[0];
    _a2_3 = res[1];
    for (int i = 0; i < n; i++) {
      double dif = y[i] - formula3(x[i]);
      _uncertainty3 += dif * dif;
    }
    print(_uncertainty3);

    isShow = true;
    notifyListeners();
  }

  double formula1(double x) {
    return 1 / (_a1_1 + _a2_1 * x);
  }

  double formula2(double x) {
    return _a1_2 * pow(e, _a2_2 * x);
  }

  double formula3(double x) {
    return _a1_3 + _a2_3 * x;
  }

  List<double> calculateA1andA2(List<double> k, List<double> g) {
    double s1 = 0, s2 = 0, s10 = 0, s11 = 0, a1, a2;
    for (int i = 0; i < n; i++) {
      s1 += k[i];
      s2 += k[i] * k[i];
      s10 += g[i];
      s11 += k[i] * g[i];
    }

    a2 = (n * s11 - s1 * s10) / (n * s2 - s1 * s1);
    a1 = (s10 - a2 * s1) / n;

    return <double>[a1, a2];
  }

  double round(double num) {
    return (num * 1000).roundToDouble() / 1000;
  }

  double getA1_1() {
    return round(_a1_1);
  }

  double getA2_1() {
    return round(_a2_1);
  }

  double getA1_2() {
    return round(_a1_2);
  }

  double getA2_2() {
    return round(_a2_2);
  }

  double getA1_3() {
    return round(_a1_3);
  }

  double getA2_3() {
    return round(_a2_3);
  }

  double getUncertainty1() {
    return round(_uncertainty1);
  }

  double getUncertainty2() {
    return round(_uncertainty2);
  }

  double getUncertainty3() {
    return round(_uncertainty3);
  }
}

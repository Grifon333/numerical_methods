import 'package:flutter/cupertino.dart';

class Lab6Model extends ChangeNotifier {
  List<List<double>> result = [];
  List<List<double>> transpMatrix = [];
  List<Offset> points = [];
  List<String> titles = [];
  bool isShow = false;
  double a = 3;
  double b = 5;
  double h = 0.2;

  void calculateByEulerMethod() {
    // int n = 2;
    // double y0 = 1.7;
    double y0 = 1.7;
    _eulerMethod(a, y0, b);

    // double dif;
    // double z1 = yResult;
    // do {
    //   n *= 2;
    //   _eulerMethod(n, a, y0, b);
    //   double z2 = yResult;
    //   dif = max(z2, z1) - min(z2, z1);
    //   z1 = z2;
    // } while (dif > 0.01);
  }

  void calculateByRungeKuttaMethod() {
    double y0 = 1.7;
    _rungeKuttaMethod(a, y0, b);
  }

  void _eulerMethod(
    // int n,
    double x0,
    double y0,
    double b,
  ) {
    // double h = (b - x0) / n;
    int k = 0;
    result = List.generate(11, (_) => List.filled(5, 0));
    titles = List.filled(5, '-');
    points.clear();
    titles[0] = 'i';
    titles[1] = 'x';
    titles[2] = 'y';
    titles[3] = 'f';
    titles[4] = '∆y';

    do {
      result[k][0] = k.toDouble() + 1;
      result[k][1] = x0;
      result[k][2] = y0;
      points.add(Offset(x0, y0));
      double f = formula(x0, y0);
      double step = h * f;
      y0 += step;
      x0 += h;

      result[k][3] = f;
      result[k][4] = step;
      k++;
    } while (x0 <= b);

    result[k][0] = k.toDouble() + 1;
    result[k][1] = x0;
    result[k][2] = y0;
    points.add(Offset(x0, y0));
    double f = formula(x0, y0);
    double step = h * f;
    y0 += step;
    x0 += h;
    result[k][3] = f;
    result[k][4] = step;

    isShow = true;
    _transpositionMatrix();
    notifyListeners();
  }

  void _rungeKuttaMethod(
    double x0,
    double y0,
    double b,
  ) {
    int k = 0;
    // int n = (b - x0) ~/ h;

    // result = List.generate(5 * n + 4, (_) => List.filled(5, 0));
    result = List.generate(50, (_) => List.filled(6, 0));
    titles = List.filled(6, '-');
    points.clear();
    titles[0] = 'i';
    titles[1] = 'x';
    titles[2] = 'y';
    titles[3] = 'f';
    titles[4] = 'k';
    titles[5] = '∆y';

    do {
      result[k * 5][0] = k.toDouble() + 1;
      result[k * 5][1] = x0;
      result[k * 5 + 1][1] = x0 + h / 2;
      result[k * 5 + 2][1] = x0 + h / 2;
      result[k * 5 + 3][1] = x0 + h;
      result[k * 5][2] = y0;
      points.add(Offset(x0, y0));

      double f1 = formula(x0, y0);
      double k1 = h * f1;
      result[k * 5 + 1][2] = y0 + k1 / 2;
      double f2 = formula(x0 + h / 2, y0 + k1 / 2);
      double k2 = h * f2;
      result[k * 5 + 2][2] = y0 + k2 / 2;
      double f3 = formula(x0 + h / 2, y0 + k2 / 2);
      double k3 = h * f3;
      result[k * 5 + 3][2] = y0 + k3;
      double f4 = formula(x0 + h, y0 + k3);
      double k4 = h * f4;

      result[k * 5][3] = f1;
      result[k * 5 + 1][3] = f2;
      result[k * 5 + 2][3] = f3;
      result[k * 5 + 3][3] = f4;

      result[k * 5][4] = k1;
      result[k * 5 + 1][4] = k2;
      result[k * 5 + 2][4] = k3;
      result[k * 5 + 3][4] = k4;

      result[k * 5][5] = k1;
      result[k * 5 + 1][5] = 2 * k2;
      result[k * 5 + 2][5] = 2 * k3;
      result[k * 5 + 3][5] = k4;

      double sum = (k1 + 2 * k2 + 2 * k3 + k4) / 6;
      result[k * 5 + 4][5] = sum;
      y0 += sum;
      x0 += h;
      k++;
    } while (x0 <= b);

    isShow = true;
    _transpositionMatrix();
    notifyListeners();
  }

  double formula(double x, double y) {
    return (2 * x * y / (x + 4)) - 0.4;
  }

  double round(double value) {
    return (value * 10000).roundToDouble() / 10000;
  }

  void _transpositionMatrix() {
    transpMatrix = List.generate(
        result[0].length, (index) => List.filled(result.length, 0.0));
    for (int i = 0; i < result.length; i++) {
      for (int j = 0; j < result[i].length; j++) {
        transpMatrix[j][i] = round(result[i][j]);
      }
    }
  }
}

import 'package:flutter/cupertino.dart';

class Lab6Model extends ChangeNotifier {
  // double xResult = 0;
  // double yResult = 0;
  List<double> xList = List.filled(11, 0);
  List<double> yList = List.filled(11, 0);
  List<double> fList = List.filled(11, 0);

  List<double> k1List = List.filled(11, 0);
  List<double> k2List = List.filled(11, 0);
  List<double> k3List = List.filled(11, 0);
  List<double> k4List = List.filled(11, 0);

  List<double> stepList = List.filled(11, 0);
  bool isShow = false;

  void calculateByEulerMethod() {
    // int n = 2;
    double a = 3;
    double b = 5;
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
    double a = 3;
    double b = 5;
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
    double h = 0.2;
    int k = 0;
    double x, y;
    xList[k] = x0;
    yList[k] = y0;
    fList[k] = formula(x0, y0);
    stepList[k] = fList[k] * h;
    do {
      x = x0;
      y = y0;
      y0 = y0 + h * formula(x, y);
      x0 = x0 + h;
      k++;
      xList[k] = x0;
      yList[k] = y0;
      fList[k] = formula(x0, y0);
      stepList[k] = fList[k] * h;
    } while (x0 <= b);

    // xResult = x;
    // yResult = y;
    isShow = true;
    notifyListeners();
  }

  void _rungeKuttaMethod(
    double x0,
    double y0,
    double b,
  ) {
    double h = 0.2;
    int k = 0;

    do {
      xList[k] = x0;
      yList[k] = y0;

      k1List[k] = h * formula(x0, y0);
      k2List[k] = h * formula(xList[k] + h / 2, yList[k] + k1List[k] / 2);
      k3List[k] = h * formula(xList[k] + h / 2, yList[k] + k2List[k] / 2);
      k4List[k] = h * formula(xList[k] + h, yList[k] + k3List[k]);

      y0 = y0 + (k1List[k] + 2 * (k2List[k] + k3List[k]) + k4List[k]) / 6;
      x0 += h;
      k++;
    } while (x0 <= b);

    xList[k] = x0;
    yList[k] = y0;

    k1List[k] = h * formula(x0, y0);
    k2List[k] = h * formula(xList[k] + h / 2, yList[k] + k1List[k] / 2);
    k3List[k] = h * formula(xList[k] + h / 2, yList[k] + k2List[k] / 2);
    k4List[k] = h * formula(xList[k] + h, yList[k] + k3List[k]);

    isShow = true;
    notifyListeners();
  }

  double formula(double x, double y) {
    return (2 * x * y / (x + 4)) - 0.4;
  }

  double round(double value) {
    return (value * 10000).roundToDouble() / 10000;
  }

  String getX() {
    return xList.map((e) => round(e)).join('\n');
  }

  String getY() {
    return yList.map((e) => round(e)).join('\n');
  }

  String getF() {
    return fList.map((e) => round(e)).join('\n');
  }

  String getStep() {
    return stepList.map((e) => round(e)).join('\n');
  }
}

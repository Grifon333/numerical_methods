import 'dart:math';

import 'package:flutter/cupertino.dart';

class Lab7Model extends ChangeNotifier {
  final n = 5;
  final a = 0.0;
  final b = 10.0;
  final h = 0.5;
  final x = List.filled(5, 0.0);
  final y = List.filled(5, 0.0);

  void interpolation() {
    _fillCoordinates();

    for (double z = a; z <= b; z += h) {
      double result = 0;
      for (int i = 0; i < n; i++) {
        double p = 1;
        for (int j = 0; j < n; j++) {
          if (j != i) {
            p *= (z - x[j]) / (x[i] - x[j]);
          }
        }
        result += y[i] * p;
      }

      double yReal = formula(z);
      double delta = max(yReal, result) - min(yReal, result);
      print('x = $z');
      print('y(inter) = $result');
      print('y(real) = $yReal');
      print('∆ = $delta');
      print('');
    }
  }

  void _fillCoordinates() {
    for (int i = 0; i < n; i++) {
      x[i] = a + i * (b - a) / (n - 1);
      y[i] = formula(x[i]);
    }
    print(x);
    print(y);
  }

  double formula(double x) {
    return log(x + 1);
  }
}

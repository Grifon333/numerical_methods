import 'dart:math';

import 'package:flutter/cupertino.dart';

class Lab4Model extends ChangeNotifier {
  final a = List.generate(3, (_) => List.filled(3, 0.0));
  final b = List.filled(3, 0.0);
  final result = List.filled(3, 0.0);
  int countIterations = 0;
  final uncertainty = List.filled(3, 0.0);
  bool isShow = false;
  double accurate = 0.00001;

  void writingValueToMatrix(double value, int row, int column) {
    if (column == 3) {
      b[row] = value;
    } else {
      a[row][column] = value;
    }
  }

  void calculateByIterations() {
    iterationMethod(usePreviousX: false);
  }

  void calculateByGaussSeidel() {
    iterationMethod(usePreviousX: true);
  }

  void iterationMethod({required bool usePreviousX}) {
    List<double> oldX = List.filled(3, 0);
    List<double> x = List.filled(3, 0);

    countIterations = 0;
    do {
      oldX[0] = x[0];
      oldX[1] = x[1];
      oldX[2] = x[2];
      for (int i = 0; i < 3; i++) {
        x[i] = b[i] / a[i][i];
        for (int j = 0; j < 3; j++) {
          if (i == j) continue;
          if (usePreviousX) {
            x[i] -= (a[i][j] / a[i][i]) * x[j];
          } else {
            x[i] -= (a[i][j] / a[i][i]) * oldX[j];
          }
        }
      }
      countIterations++;
    } while (!(max(oldX[0], x[0]) - min(oldX[0], x[0]) < accurate &&
        max(oldX[1], x[1]) - min(oldX[1], x[1]) < accurate &&
        max(oldX[2], x[2]) - min(oldX[2], x[2]) < accurate));

    for (int i = 0; i < result.length; i++) {
      result[i] = round(x[i]);
    }

    for (int i = 0; i < a.length; i++) {
      uncertainty[i] = 0;
      for (int j = 0; j < a[i].length; j++) {
        uncertainty[i] += a[i][j] * x[j];
      }
      uncertainty[i] -= b[i];
      uncertainty[i] = module(uncertainty[i]);
    }

    isShow = true;
    notifyListeners();
  }

  double module(double value) {
    if (value < 0) {
      return value * -1;
    }
    return value;
  }

  double round(double number) {
    return (number * 1000000).roundToDouble() / 1000000;
  }

  String getResult() {
    return result.join('\n');
  }

  String getUncertainty() {
    return uncertainty
        .map((el) => round(el * 100000) != 0
            ? '${round(el * 100000)} e-5'
            : '${round(el * 100000)}')
        .join('\n');
  }
}

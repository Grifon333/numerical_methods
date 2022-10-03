import 'package:flutter/material.dart';

class Lab3Model extends ChangeNotifier {
  final matrixCoefficient = List.generate(3, (_) => List.filled(3, 0.0));
  final matrixY = List.filled(3, 0.0);
  final matrixX = List.filled(3, 0.0);

  void writingValueToMatrix(double value, int row, int column) {
    if (column == 3) {
      matrixY[row] = value;
    } else {
      matrixCoefficient[row][column] = value;
    }
  }

  void calculateByGauss() {
    final a = List.generate(3, (_) => List.filled(3, 0.0));
    final b = List.filled(3, 0.0);

    for (int i = 0; i < matrixCoefficient.length; i++) {
      for (int j = 0; j < matrixCoefficient[i].length; j++) {
        a[i][j] = matrixCoefficient[i][j];
      }
      b[i] = matrixY[i];
    }

    int n = a.length;
    double max;
    int rowMax;
    for (int k = 0; k < n; k++) {
      max = module(a[k][k]);
      rowMax = k;

      for (int i = k + 1; i < n; i++) {
        double num = module(a[i][k]);
        if (num > max) {
          max = num;
          rowMax = i;
        }
      }

      for (int j = 0; j < n; j++) {
        double t = a[k][j];
        a[k][j] = a[rowMax][j];
        a[rowMax][j] = t;
      }
      double t = b[k];
      b[k] = b[rowMax];
      b[rowMax] = t;

      for (int i = k + 1; i < n; i++) {
        double M = a[i][k] / a[k][k];

        for (int j = 0; j < n; j++) {
          a[i][j] -= M * a[k][j];
        }

        b[i] -= M * b[k];
      }
    }

    if (round(a[n - 1][n - 1]) == 0) {
      if (round(b[n - 1]) == 0) {
        print('Infinity');
      } else {
        print('Empty');
      }
    } else {
      for (int i = n - 1; i >= 0; i--) {
        double sum = 0;

        for (int j = i + 1; j < n; j++) {
          sum += a[i][j] * matrixX[j];
        }

        matrixX[i] = (b[i] - sum) / a[i][i];
        print('x[$i] = ${matrixX[i]}');
      }
    }
  }

  void show() {
    // print(matrix);
    // print(matrixByGauss);
  }

  double module(double value) {
    if (value < 0) {
      return value * -1;
    }
    return value;
  }

  double round(double number) {
    return (number * 1000000000).roundToDouble() / 1000000000;
  }
}

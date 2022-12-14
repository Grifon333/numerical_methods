import 'dart:math';

import 'package:flutter/material.dart';

class Lab3Model extends ChangeNotifier {
  final matrixCoefficient = List.generate(3, (_) => List.filled(3, 0.0));
  final matrixY = List.filled(3, 0.0);
  final matrixX = List.filled(3, 0.0);
  final uncertainty = List.filled(3, 0.0);
  bool isShow = false;
  List interimResult = [];

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
      }
    }

    interimResult.clear();
    resetData();
  }

  void calculateByLU() {
    final a = List.generate(3, (_) => List.filled(3, 0.0));
    final b = List.filled(3, 0.0);
    final l = List.generate(3, (_) => List.filled(3, 0.0));
    final u = List.generate(3, (_) => List.filled(3, 0.0));
    final y = List.filled(3, 0.0);

    for (int i = 0; i < matrixCoefficient.length; i++) {
      for (int j = 0; j < matrixCoefficient[i].length; j++) {
        a[i][j] = matrixCoefficient[i][j];
      }
      b[i] = matrixY[i];
    }
    int n = a.length;

    for (int i = 0; i < n; i++) {
      for (int k = 0; k < n; k++) {
        if (k <= i) {
          double sum = 0;
          for (int j = 0; j < k; j++) {
            sum += l[i][j] * u[j][k];
          }
          l[i][k] = a[i][k] - sum;
        } else if (i < k) {
          double sum = 0;
          for (int j = 0; j < i; j++) {
            sum += l[i][j] * u[j][k];
          }
          u[i][k] = (a[i][k] - sum) / l[i][i];
        }
        u[k][k] = 1;
      }
    }

    y[0] = b[0] / l[0][0];
    for (int i = 1; i < n; i++) {
      double sum = 0;
      for (int k = 0; k < i; k++) {
        sum += l[i][k] * y[k];
      }
      y[i] = (b[i] - sum) / l[i][i];
    }

    matrixX[n - 1] = y[n - 1];
    for (int i = n - 2; i >= 0; i--) {
      double sum = 0;
      for (int k = i + 1; k < n; k++) {
        sum += u[i][k] * matrixX[k];
      }
      matrixX[i] = y[i] - sum;
    }

    interimResult.clear();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < l.length; i++) {
      sb.write(l[i].map((e) => round(e)).join('\t\t\t'));
      if (i == l.length - 1) {
        continue;
      }
      sb.write('\n');
    }
    String lStr = sb.toString();
    interimResult.add(['L', lStr]);

    sb = StringBuffer();
    for (int i = 0; i < u.length; i++) {
      sb.write(u[i].map((e) => round(e)).join('\t\t\t'));
      if (i == u.length - 1) {
        continue;
      }
      sb.write('\n');
    }
    String uStr = sb.toString();
    interimResult.add(['U', uStr]);

    resetData();
  }

  void calculateBySquareRoot() {
    final a = List.generate(3, (_) => List.filled(3, 0.0));
    final b = List.filled(3, 0.0);
    final t = List.generate(3, (_) => List.filled(3, 0.0));
    final y = List.filled(3, 0.0);

    int n = a.length;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        a[2-i][j] = matrixCoefficient[i][j];
      }
      b[2-i] = matrixY[i];
    }

    t[0][0] = sqrt(a[0][0]);
    for (int j = 1; j < n; j++) {
      t[0][j] = a[0][j] / t[0][0];
    }

    for (int i = 1; i < n; i++) {
      double sum = 0;
      for (int k = 0; k < i; k++) {
        sum += t[k][i] * t[k][i];
      }
      t[i][i] = sqrt(module(a[i][i] - sum));

      for (int j = 0; j < n; j++) {
        if (i < j) {
          double sum = 0;
          for (int k = 0; k < i; k++) {
            sum += t[k][i] * t[k][j];
          }
          t[i][j] = (a[i][j] - sum) / t[i][i];
        } else if (j < i) {
          t[i][j] = 0;
        }
      }
    }

    y[0] = b[0] / t[0][0];
    for (int i = 1; i < n; i++) {
      double sum = 0;
      for (int k = 0; k < i; k++) {
        sum += t[k][i] * y[k];
      }
      y[i] = (b[i] - sum) / t[i][i];
    }

    matrixX[n - 1] = y[n - 1] / t[n - 1][n - 1];
    for (int i = n - 2; i >= 0; i--) {
      double sum = 0;
      for (int k = n - 1; k > i; k--) {
        sum += t[i][k] * matrixX[k];
      }
      matrixX[i] = (y[i] - sum) / t[i][i];
    }

    interimResult.clear();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < t.length; i++) {
      sb.write(t[i].map((e) => round(e)).join('\t\t\t'));
      if (i == t.length - 1) {
        continue;
      }
      sb.write('\n');
    }
    String tStr = sb.toString();
    interimResult.add(['T', tStr]);

    resetData();
  }

  double module(double value) {
    if (value < 0) {
      return value * -1;
    }
    return value;
  }

  double round(double number) {
    return (number * 1000).roundToDouble() / 1000;
  }

  String getMatrixCoefficient() {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < matrixCoefficient.length; i++) {
      sb.write(matrixCoefficient[i].join('\t\t\t'));
      if (i == matrixCoefficient.length - 1) {
        continue;
      }
      sb.write('\n');
    }
    return sb.toString();
  }

  String getMatrixB() {
    return matrixY.join('\n');
  }

  String getMatrixX() {
    return matrixX.map((e) => round(e)).join('\n');
  }

  String getUncertainty() {
    return uncertainty.map((e) => round(e)).join('\n');
  }

  void resetData() {
    for (int i = 0; i < 3; i++) {
      double dif = matrixCoefficient[i][0] * matrixX[0] +
          matrixCoefficient[i][1] * matrixX[1] +
          matrixCoefficient[i][2] * matrixX[2] -
          matrixY[i];
      uncertainty[i] = module(dif);
    }
    isShow = true;
    notifyListeners();
  }
}

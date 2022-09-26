import 'package:flutter/material.dart';

class Lab3Model extends ChangeNotifier {
  final matrix = List.generate(3, (_) => List.filled(4, 0.0));
  List<List<double>> matrixByGauss = List.generate(3, (_) => List.filled(4, 0.0));

  void writingValueToMatrix(double value, int row, int column) {
    matrix[row][column] = value;
    // matrixByGauss[row][column] = value;
  }

  void calculateByGauss() {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        matrixByGauss[i][j] = matrix[i][j];
      }
    }

    for (int n = 0; n < 2; n++) {
      for (int i = n + 1; i < matrix.length; i++) {
        double k = -1 * matrixByGauss[i][n] / matrixByGauss[n][n];
        for (int j = n; j < matrix[i].length; j++) {
          matrixByGauss[i][j] = matrixByGauss[i][j] + (matrixByGauss[n][j] * k);
        }
      }
    }

    final x3 = matrixByGauss[2][3] / matrixByGauss[2][2];
    final x2 =
        (matrixByGauss[1][3] - matrixByGauss[1][2] * x3) / matrixByGauss[1][1];
    final x1 = (matrixByGauss[0][3] -
            matrixByGauss[0][2] * x3 -
            matrixByGauss[0][1] * x2) /
        matrixByGauss[0][0];

    print('x1 = $x1\nx2 = $x2\nx3 = $x3');
  }

  void show() {
    print(matrix);
    print(matrixByGauss);
  }
}

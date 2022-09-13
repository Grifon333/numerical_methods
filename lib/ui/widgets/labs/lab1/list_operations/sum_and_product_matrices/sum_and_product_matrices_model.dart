import 'package:flutter/material.dart';

class SumAndProductsMatricesModel extends ChangeNotifier {
  final _dimensions = [1, 2, 3, 4, 5, 6];
  int _heightFirst = 3;
  int _widthFirst = 3;
  int _heightSecond = 3;
  int _widthSecond = 3;

  List<List<int>> matrixFirst = List.generate(6, (_) => List.filled(6, 0));
  List<List<int>> matrixSecond = List.generate(6, (_) => List.filled(6, 0));
  List<List<int>> _resultSum = [];
  List<List<int>> _resultDifference = [];
  List<List<int>> _resultProduct = [];
  String _resultSumString = '';
  String _resultDifferenceString = '';
  String _resultProductString = '';

  int get heightFirst => _heightFirst;

  int get widthFirst => _widthFirst;

  int get heightSecond => _heightSecond;

  int get widthSecond => _widthSecond;

  List<int> get dimensions => _dimensions;

  String get resultSumString => _resultSumString;

  String get resultDifferenceString => _resultDifferenceString;

  String get resultProductString => _resultProductString;

  set setResultSumString(String value) {
    _resultSumString = value;
    notifyListeners();
  }

  set setResultDifferenceString(String value) {
    _resultDifferenceString = value;
    notifyListeners();
  }

  set setResultProductString(String value) {
    _resultProductString = value;
    notifyListeners();
  }

  void changeHeightFirst(int? value) {
    if (_heightFirst == value) return;
    if (value == null) {
      _heightFirst = 3;
    } else {
      _heightFirst = value;
    }
    notifyListeners();
  }

  void changeWidthFirst(int? value) {
    if (_widthFirst == value) return;
    if (value == null) {
      _widthFirst = 3;
    } else {
      _widthFirst = value;
    }
    notifyListeners();
  }

  void changeHeightSecond(int? value) {
    if (_heightSecond == value) return;
    if (value == null) {
      _heightSecond = 3;
    } else {
      _heightSecond = value;
    }
    notifyListeners();
  }

  void changeWidthSecond(int? value) {
    if (_widthSecond == value) return;
    if (value == null) {
      _widthSecond = 3;
    } else {
      _widthSecond = value;
    }
    notifyListeners();
  }

  void sumCalculate() {
    _resultSum =
        List.generate(_heightFirst, (index) => List.filled(_widthFirst, 0));
    for (int i = 0; i < _heightFirst; i++) {
      for (int j = 0; j < _widthFirst; j++) {
        _resultSum[i][j] = matrixFirst[i][j] + matrixSecond[i][j];
      }
    }
    _resultSumString = '';
    for (int i = 0; i < _resultSum.length; i++) {
      _resultSumString += _resultSum[i].join("  ");
      if (i < _resultSum.length - 1) {
        _resultSumString += '\n';
      }
    }
    notifyListeners();
  }

  void differenceCalculate() {
    _resultDifference =
        List.generate(_heightFirst, (index) => List.filled(_widthFirst, 0));
    for (int i = 0; i < _heightFirst; i++) {
      for (int j = 0; j < _widthFirst; j++) {
        _resultDifference[i][j] = matrixFirst[i][j] - matrixSecond[i][j];
      }
    }
    _resultDifferenceString = '';
    for (int i = 0; i < _resultDifference.length; i++) {
      _resultDifferenceString += _resultDifference[i].join("  ");
      if (i < _resultDifference.length - 1) {
        _resultDifferenceString += '\n';
      }
    }
    notifyListeners();
  }

  void productCalculate() {
    _resultProduct =
        List.generate(_heightFirst, (index) => List.filled(_widthSecond, 0));
    for (int i = 0; i < _heightFirst; i++) {
      for (int j = 0; j < _widthSecond; j++) {
        for(int k = 0; k < _widthFirst; k++) {
          _resultProduct[i][j] += matrixFirst[i][k] * matrixSecond[k][j];
        }
      }
    }
    _resultProductString = '';
    for (int i = 0; i < _resultProduct.length; i++) {
      _resultProductString += _resultProduct[i].join("  ");
      if (i < _resultProduct.length - 1) {
        _resultProductString += '\n';
      }
    }
    notifyListeners();
  }
}

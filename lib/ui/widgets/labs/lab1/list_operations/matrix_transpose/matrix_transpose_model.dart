import 'package:flutter/material.dart';

class MatrixTransposeModel extends ChangeNotifier {
  final _dimensions = [1, 2, 3, 4, 5, 6];
  int _height = 3;
  int _width = 3;

  List<List<int>> matrix = [
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0]
  ];

  List<List<int>> _result = [];
  String _resultString = '';

  int get height => _height;

  int get width => _width;

  List<int> get dimensions => _dimensions;

  List<List<int>> get result => _result;

  String get resultString => _resultString;

  void changeHeight(int? value) {
    if (_height == value) return;
    if (value == null) {
      _height = 3;
    } else {
      _height = value;
    }
    notifyListeners();
  }

  void changeWidth(int? value) {
    if (_width == value) return;
    if (value == null) {
      _width = 3;
    } else {
      _width = value;
    }
    notifyListeners();
  }

  void resultCalculation() {
    _result = List.generate(_width, (_) => List.filled(_height, 0));
    for (int i = 0; i < _height; i++) {
      for (int j = 0; j < _width; j++) {
        _result[j][i] = matrix[i][j];
      }
    }
    _resultString = '';
    for(int i = 0; i < _result.length; i++) {
      _resultString += _result[i].join("  ");
      if (i < _result.length - 1) {
        _resultString += '\n';
      }
    }
    notifyListeners();
  }
}

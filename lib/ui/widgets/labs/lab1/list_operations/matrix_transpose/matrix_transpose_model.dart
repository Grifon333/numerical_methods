import 'package:flutter/material.dart';

class MatrixTransposeModel extends ChangeNotifier {
  final _dimensions = [1, 2, 3, 4, 5, 6];
  int _height = 3;
  int _width = 3;
  int? _scalar;

  List<List<int>> matrix = List.generate(6, (_) => List.filled(6, 0));
  List<List<int>> _resultTranspose = [];
  List<List<int>> _resultProduct = [];
  String _resultTransposeString = '';
  String _resultProductString = '';

  int get height => _height;

  int get width => _width;

  List<int> get dimensions => _dimensions;

  String get resultTransposeString => _resultTransposeString;

  String get resultProductString => _resultProductString;

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

  void transposeCalculation() {
    _resultTranspose = List.generate(_width, (_) => List.filled(_height, 0));
    for (int i = 0; i < _height; i++) {
      for (int j = 0; j < _width; j++) {
        _resultTranspose[j][i] = matrix[i][j];
      }
    }
    _resultTransposeString = '';
    for(int i = 0; i < _resultTranspose.length; i++) {
      _resultTransposeString += _resultTranspose[i].join("  ");
      if (i < _resultTranspose.length - 1) {
        _resultTransposeString += '\n';
      }
    }
    notifyListeners();
  }

  void setScalar(int value) {
    if (_scalar == value) return;
    _scalar = value;
    notifyListeners();
  }

  void productCalculation() {
    _resultProduct = List.generate(_height, (_) => List.filled(_width, 0));
    for (int i = 0; i < _height; i++) {
      for (int j = 0; j < _width; j++) {
        _resultProduct[i][j] = matrix[i][j] * (_scalar ?? 1);
      }
    }
    _resultProductString = '';
    for(int i = 0; i < _resultProduct.length; i++) {
      _resultProductString += _resultProduct[i].join("  ");
      if (i < _resultProduct.length - 1) {
        _resultProductString += '\n';
      }
    }
    notifyListeners();
  }
}

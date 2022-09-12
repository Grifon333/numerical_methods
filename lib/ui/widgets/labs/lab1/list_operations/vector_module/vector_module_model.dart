import 'package:flutter/material.dart';
import 'dart:math';

class VectorModuleModel extends ChangeNotifier {
  final _dimensions = [2, 3, 4, 5, 6];
  final _vectorForms = ['points', 'coordinates'];
  int _currentDimension = 3;
  String? _currentVectorForm = 'coordinates';

  List<int> vector = [0, 0, 0, 0, 0, 0];
  List<int> pointA = [0, 0, 0, 0, 0, 0];
  List<int> pointB = [0, 0, 0, 0, 0, 0];
  double _result = 0;

  List<int> get dimensions => _dimensions;

  List<String> get vectorForms => _vectorForms;

  int get currentDimension => _currentDimension;

  String? get currentVectorForm => _currentVectorForm;

  double get result => _result;

  void changeDimension(int? value) {
    if (_currentDimension == value) return;
    if (value == null) {
      _currentDimension = 3;
    } else {
      _currentDimension = value;
    }
    notifyListeners();
  }

  void changeVectorForm(String? value) {
    if (_currentVectorForm == value) return;
    _currentVectorForm = value;
    notifyListeners();
  }

  void resultCalculation() {
    List<int> resultVector;
    if (_currentVectorForm == 'points') {
      resultVector = List<int>.filled(6, 0);
      for (int i = 0; i < _currentDimension; i++) {
        resultVector[i] = pointB[i] - pointA[i];
      }
      resultVector = resultVector.getRange(0, _currentDimension).toList();
    } else {
      resultVector = vector
          .getRange(0, _currentDimension)
          .toList();
    }

    int t = 0;
    for(int i = 0; i < _currentDimension; i++) {
      t += resultVector[i] * resultVector[i];
    }
    _result = (sqrt(t) * 1000).roundToDouble() / 1000;

    notifyListeners();
  }
}
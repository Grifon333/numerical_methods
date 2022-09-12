import 'package:flutter/material.dart';

class ScalarProductOfVectorModel extends ChangeNotifier {
  final _dimensions = [2, 3, 4, 5, 6];
  int _currentDimension = 3;
  final _vectorForms = ['points', 'coordinates'];
  String _currentVectorFormFirst = 'coordinates';
  String _currentVectorFormSecond = 'coordinates';

  List<int> firstVector = List<int>.filled(6, 0);
  List<int> firstPointA = List<int>.filled(6, 0);
  List<int> firstPointB = List<int>.filled(6, 0);
  List<int> secondVector = List<int>.filled(6, 0);
  List<int> secondPointA = List<int>.filled(6, 0);
  List<int> secondPointB = List<int>.filled(6, 0);
  int _result = 0;

  List<int> get dimensions => _dimensions;

  List<String> get vectorForms => _vectorForms;

  int get currentDimension => _currentDimension;

  String get currentVectorFormFirst => _currentVectorFormFirst;

  String get currentVectorFormSecond => _currentVectorFormSecond;

  int get result => _result;

  void changeDimension(int? value) {
    if (value == null) {
      _currentDimension = 3;
    } else {
      _currentDimension = value;
    }
    notifyListeners();
  }

  void changeVectorFormFirst(String? value) {
    if (_currentVectorFormFirst == value) return;
    if (value == null) {
      _currentVectorFormFirst = 'coordinates';
    } else {
      _currentVectorFormFirst = value;
    }
    notifyListeners();
  }

  void changeVectorFormSecond(String? value) {
    if (_currentVectorFormSecond == value) return;
    if (value == null) {
      _currentVectorFormSecond = 'coordinates';
    } else {
      _currentVectorFormSecond = value;
    }
    notifyListeners();
  }

  void resultCalculation() {
    List<int> firstV = List<int>.filled(6, 0), secondV = List<int>.filled(6, 0);

    if (_currentVectorFormFirst == 'points') {
      for (int i = 0; i < _currentDimension; i++) {
        firstV[i] = firstPointB[i] - firstPointA[i];
      }
      firstV = firstV.getRange(0, _currentDimension).toList();
    } else {
      firstV = firstVector.getRange(0, _currentDimension).toList();
    }

    if (_currentVectorFormSecond == 'points') {
      for (int i = 0; i < _currentDimension; i++) {
        secondV[i] = secondPointB[i] - secondPointA[i];
      }
      secondV = secondV.getRange(0, _currentDimension).toList();
    } else {
      secondV = secondVector.getRange(0, _currentDimension).toList();
    }

    _result = 0;
    for (int i = 0; i < _currentDimension; i++) {
      _result += firstV[i] * secondV[i];
    }

    notifyListeners();
  }
}

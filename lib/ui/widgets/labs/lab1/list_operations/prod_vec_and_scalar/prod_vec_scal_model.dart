import 'package:flutter/material.dart';

class ProdVecScalModel extends ChangeNotifier {
  final _dimensions = [2, 3, 4, 5, 6];
  final _vectorForms = ['points', 'coordinates'];
  int _currentDimension = 3;
  String? _currentVectorForm = 'coordinates';

  List<int> vector = [0, 0, 0, 0, 0, 0];
  List<int> pointA = [0, 0, 0, 0, 0, 0];
  List<int> pointB = [0, 0, 0, 0, 0, 0];
  int? _scalar;
  List<int> _resultVector = [];

  List<int> get dimensions => _dimensions;

  List<String> get vectorForms => _vectorForms;

  int get currentDimension => _currentDimension;

  String? get currentVectorForm => _currentVectorForm;

  List<int> get resultVector => _resultVector;

  void setScalar(int value) {
    _scalar = value;
    notifyListeners();
  }

  void changeDimension(int? value) {
    if (value == null) {
      _currentDimension = 3;
    } else {
      _currentDimension = value;
    }
    notifyListeners();
  }

  void changeVectorForm(String? value) {
    _currentVectorForm = value;
    notifyListeners();
  }

  void resultCalculation() {
    if (_currentVectorForm == 'points') {
      _resultVector = List<int>.filled(6, 0);
      for (int i = 0; i < _currentDimension; i++) {
        _resultVector[i] = (pointB[i] - pointA[i]) * (_scalar ?? 1);
      }
      _resultVector = _resultVector.getRange(0, _currentDimension).toList();
    } else {
      _resultVector = vector
          .getRange(0, _currentDimension)
          .map((int e) => e * (_scalar ?? 1))
          .toList();
    }
    notifyListeners();
  }
}

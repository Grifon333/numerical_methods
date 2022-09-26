import 'package:flutter/material.dart';
import 'dart:math';

class Lab2Model extends ChangeNotifier {
  final double _start = -3;
  final double _end = 6;
  double _a = 0.5;
  double _b = 0.8;
  final double accuracy = 0.00001;
  final double functionLimit = 0;
  int _countIterations = 0;
  int _duration = 0;
  String _result = '';
  final List<String> _steps = [];
  final List<String> _stepsFunctions = [];
  String? _resultBySteps;
  String? _resultFunctionBySteps;

  final _methods = ['Half Divider', 'Iteration', 'Chords', 'Newton'];
  String _currentMethod = 'Half Divider';

  double get start => _start;

  double get end => _end;

  String get currentMethod => _currentMethod;

  int get countIterations => _countIterations;

  List<String> get methods => _methods;

  int get duration => _duration;

  String get result => _result;

  String? get resultBySteps => _resultBySteps;

  String? get resultFunctionBySteps => _resultFunctionBySteps;

  double get a => _a;

  double get b => _b;

  void setA(double value) {
    _a = value;
  }

  void setB(double value) {
    _b = value;
  }

  void calculateByHalfDivide() {
    var left = _a;
    var right = _b;
    _resetData();
    DateTime time = DateTime.now();

    _steps.add(
        'Step ${_countIterations + 1}: \na = ${round(left)}, \nb = ${round(right)}');
    _stepsFunctions.add(
        '\nf(a) = ${round(formula(left))}\nf(b) = ${round(formula(right))}');

    while (right - left > accuracy) {
      final t = (left + right) / 2;
      var f1 = formula(left);
      var f2 = formula(t);
      if (f1 * f2 <= 0) {
        right = t;
      } else {
        left = t;
        f1 = f2;
      }
      _countIterations++;

      _steps.add(
          'Step ${_countIterations + 1}: \na = ${round(left)}, \nb = ${round(right)}');
      _stepsFunctions.add(
          '\nf(a) = ${round(formula(left))}\nf(b) = ${round(formula(right))}');
    }

    _result =
        'a = ${round(left)} \nb = ${round(right)} \nf(a) = ${formula(left)} \nf(b) = ${formula(right)}';
    _updateData(time);
  }

  void calculateByIteration() {
    double dis = 1;
    var x = _a;
    int maxIterations = 100;
    _resetData();
    DateTime time = DateTime.now();

    _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
    _stepsFunctions.add('\nf(x) = ${round(formula(x))}');

    while (dis > accuracy && _countIterations < maxIterations) {
      var x0 = x;
      x = 0.5 - log(x) / log(10);
      dis = max(x, x0) - min(x, x0);
      _countIterations++;

      _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
      _stepsFunctions.add('\nf(x) = ${round(formula(x))}');
    }

    _result = 'x = ${round(x)} \nf(x) = ${formula(x)}';
    _updateData(time);
  }

  void calculateByChords() {
    double x = _a;
    double xLast = _b;
    double xGrandLast;
    double dif = 1;
    _resetData();
    DateTime time = DateTime.now();

    _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
    _stepsFunctions.add('\nf(x) = ${round(formula(x))}');

    while (dif > accuracy) {
      xGrandLast = xLast;
      xLast = x;
      x -= formula(xLast) *
          (xLast - xGrandLast) /
          (formula(xLast) - formula(xGrandLast));
      dif = max(x, xLast) - min(x, xLast);
      _countIterations++;

      _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
      _stepsFunctions.add('\nf(x) = ${round(formula(x))}');
    }

    _result = 'x = ${round(x)} \nf(x) = ${formula(x)}';
    _updateData(time);
  }

  void calculateByNewton() {
    double x = _a;
    double dif = 1;
    _resetData();
    DateTime time = DateTime.now();

    _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
    _stepsFunctions.add('\nf(x) = ${round(formula(x))}');

    while (dif > accuracy) {
      double xNext = x - formula(x) / (1 + 1 / (x * ln10));
      dif = max(x, xNext) - min(x, xNext);
      x = xNext;
      _countIterations++;

      _steps.add('Step ${_countIterations + 1}: \nx = ${round(x)}');
      _stepsFunctions.add('\nf(x) = ${round(formula(x))}');
    }

    _result = 'x = ${round(x)} \nf(x) = ${formula(x)}';
    _updateData(time);
  }

  double formula(double x) {
    return (x + log(x) / log(10) - 0.5);
  }

  void changeMethod(String? value) {
    if (_currentMethod == value || value == null) return;
    _currentMethod = value;
    notifyListeners();
  }

  int currentMethodNumber() {
    return _methods.indexOf(_currentMethod);
  }

  void _resetData() {
    _countIterations = 0;
    _steps.clear();
    _stepsFunctions.clear();
  }

  void _updateData(DateTime time) {
    _duration = DateTime.now().difference(time).inMicroseconds;
    _resultBySteps = _steps.join('\n');
    _resultFunctionBySteps = _stepsFunctions.join('\n');
    notifyListeners();
  }
}

double round(double number) {
  return (number * 1000000).roundToDouble() / 1000000;
}

import 'package:flutter/material.dart';
import 'dart:math';

class Lab2Model extends ChangeNotifier {
  final double _start = -3;
  final double _end = 6;
  final double a = 0.5;
  final double b = 0.8;
  final double accuracy = 0.00001;
  final double functionLimit = 0;
  int _countIterations = 0;
  int _duration = 0;
  String _result = '';

  final _methods = ['Half Divider', 'Iteration', 'Chords', 'Newton'];
  String _currentMethod = 'Half Divider';

  double get start => _start;

  double get end => _end;

  String get currentMethod => _currentMethod;

  int get countIterations => _countIterations;

  List<String> get methods => _methods;

  int get duration => _duration;

  String get result => _result;

  void calculateByHalfDivide() {
    var left = a;
    var right = b;
    _countIterations = 0;
    DateTime time = DateTime.now();

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
    }

    _duration = DateTime.now().difference(time).inMicroseconds;
    _result = 'a = $left \nb = $right';
    notifyListeners();
  }

  void calculateByIteration() {
    double dis = 1;
    var x = a;
    int maxIterations = 100;
    _countIterations = 0;
    DateTime time = DateTime.now();

    while (dis > accuracy && _countIterations < maxIterations) {
      var x0 = x;
      x = 0.5 - log(x) / log(10);
      dis = max(x, x0) - min(x, x0);
      _countIterations++;
    }

    _duration = DateTime.now().difference(time).inMicroseconds;
    _result = 'x = $x';
    notifyListeners();
  }

  void calculateByChords() {
    double x = a;
    double xLast = b;
    double xGrandLast;
    double dif = 1;
    _countIterations = 0;
    DateTime time = DateTime.now();

    while (dif > accuracy) {
      xGrandLast = xLast;
      xLast = x;
      x -= formula(xLast) *
          (xLast - xGrandLast) /
          (formula(xLast) - formula(xGrandLast));
      dif = max(x, xLast) - min(x, xLast);
      _countIterations++;
    }

    _duration = DateTime.now().difference(time).inMicroseconds;
    _result = 'x = $x';
    notifyListeners();
  }

  void calculateByNewton() {
    double x = a;
    double dif = 1;
    _countIterations = 0;
    DateTime time = DateTime.now();

    while (dif > accuracy) {
      double xNext = x - formula(x) / (1 + 1 / (x * ln10));
      dif = max(x, xNext) - min(x, xNext);
      x = xNext;
      _countIterations++;
    }

    _duration = DateTime.now().difference(time).inMicroseconds;
    _result = 'x = $x';
    notifyListeners();
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
}

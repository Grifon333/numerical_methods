import 'package:flutter/material.dart';

class Lab1Model extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void setSelectedTab(int value) {
    if (_selectedTab == value) return;
    _selectedTab = value;
    notifyListeners();
  }
}
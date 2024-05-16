import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  int _currentPage = 0;
  late PageController _pageController;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  FormProvider() {
    _pageController = PageController(initialPage: _currentPage);
  }

  PageController get pageController => _pageController;

  void nextPage() {
    _currentPage++;
    _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.ease);
    notifyListeners();
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }
}

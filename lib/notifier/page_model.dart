import 'package:flutter/cupertino.dart';

class PageModel extends ChangeNotifier{
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setCurrentPage(int page){
    _currentPage = page;
    notifyListeners();
  }
}

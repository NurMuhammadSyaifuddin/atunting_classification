import 'package:flutter/foundation.dart';


class AnswerModel extends ChangeNotifier {

  Map<int, int> _currentRadio = {};
  Map<int, int> get currentRadio => _currentRadio;


  void setCurrentRadio(int page, int index){
    _currentRadio[index] = page;
    notifyListeners();
  }


}
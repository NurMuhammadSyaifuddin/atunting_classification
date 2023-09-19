import 'package:flutter/cupertino.dart';

class ScoreModel extends ChangeNotifier {
  final List<int> _scores = List.filled(30, 0);
  final List<int> _selectedItem = [];

  void addOrUpdateScore(int index, int value){
    _scores[index] = value;
    notifyListeners();
  }

  void addSelectedItem(int value){
    _selectedItem.add(value);
    notifyListeners();
  }

  double getMeanHipotetik() {
    final double mean = _scores.reduce((value, element) => value + element) / _scores.length;
    return double.parse(mean.toStringAsFixed(2));
  }

  String getClassification() {
    if (getMeanHipotetik() > 1.5){
      return 'Tinggi';
    } else if (getMeanHipotetik() == 1.5 ){
      return 'Sedang';
    }
    return 'Rendah';
  }

  int getCountAnswer() => _selectedItem.length;

}
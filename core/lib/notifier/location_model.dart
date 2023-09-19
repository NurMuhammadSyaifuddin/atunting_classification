import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel extends ChangeNotifier{
  late Position _currentPosition;
  Position get currentPosition => _currentPosition;

  void setCurrentPosition(Position position){
    _currentPosition = position;
    notifyListeners();
  }
}

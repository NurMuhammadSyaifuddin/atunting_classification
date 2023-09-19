import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/result_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ResultHistoryProvider extends ChangeNotifier{

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendResult(ResultHistory resultHistory, String email) async {
    try {
      await _firebaseFirestore.collection(email).add(resultHistory.toMap());
      notifyListeners();
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

}
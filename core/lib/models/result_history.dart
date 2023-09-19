import 'package:cloud_firestore/cloud_firestore.dart';

class ResultHistory {
  String date;
  double score;
  String classification;

  ResultHistory({required this.date, required this.score, required this.classification});

  Map<String, dynamic> toMap() => {
    'date': date,
    'score': score,
    'classification': classification
  };

  factory ResultHistory.fromFirestore(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ResultHistory(date: data['date'], score: data['score'], classification: data['classification']);
  }
}
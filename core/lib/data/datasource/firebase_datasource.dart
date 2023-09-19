import 'dart:convert';

import 'package:core/models/inspection.dart';
import 'package:core/models/inspection_response.dart';
import 'package:core/models/news.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/news_response.dart';

class FirebaseDataSource {
  final DatabaseReference _newsRef =
      FirebaseDatabase.instance.ref();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<News>> getNewsList() async {
    try {
      DataSnapshot snapshot = await _newsRef.get();
      return NewsResponse.fromJson(json.decode(json.encode(snapshot.value))).newsList;
    } on Exception {
      return [];
    }
  }

  Future<List<Inspection>> getInspections() async {
    try {
      DataSnapshot snapshot = await _newsRef.get();
      return InspectionResponse.fromJson(json.decode(json.encode(snapshot.value))).inspections;
    } on Exception {
      return [];
    }
  }

  Future<String> getNewsImage(String imageUrl) async {
    Reference ref = _storage.ref().child(imageUrl);
    String url = await ref.getDownloadURL();
    return url;
  }
}

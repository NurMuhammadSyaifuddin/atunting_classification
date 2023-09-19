import 'dart:io';

import 'package:core/data/datasource/firebase_datasource.dart';
import 'package:core/domain/repositories/news_repository.dart';
import 'package:core/models/inspection.dart';
import 'package:core/models/news.dart';
import 'package:core/models/result_history.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsRepositoryImpl implements NewsRepository{

  final FirebaseDataSource _dataSource;
  final FirebaseFirestore _firebaseFirestore;

  NewsRepositoryImpl(this._dataSource, this._firebaseFirestore);

  @override
  Future<Either<Failure, String>> getNewsImage(String imageUrl) async {
    try {
      final image = await _dataSource.getNewsImage(imageUrl);
      return Right(image);
    } on SocketException catch (e){
      return Left(ConnectionFailure(e.message));
    } on FirebaseException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<News>>> getNewsList() async {
    try {
      final newsList = await _dataSource.getNewsList();
      return Right(newsList);
    } on SocketException catch (e){
      return Left(ConnectionFailure(e.message));
    } on FirebaseException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Inspection>>> getInspection() async {
    try {
      final inspections = await _dataSource.getInspections();
      return Right(inspections);
    } on SocketException catch (e){
      return Left(ConnectionFailure(e.message));
    } on FirebaseException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResultHistory>>> getResultHistory(String email) async {
    try {
      CollectionReference collection = _firebaseFirestore.collection(email);
      QuerySnapshot querySnapshot = await collection.get().timeout(const Duration(seconds: 60));

      List<ResultHistory> data = querySnapshot.docs.map((e) => ResultHistory.fromFirestore(e)).toList();
      print(data);
      return Right(data);
    } on SocketException catch (e){
      return Left(ConnectionFailure(e.message));
    } on FirebaseException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

}
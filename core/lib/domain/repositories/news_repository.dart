import 'package:core/models/inspection.dart';
import 'package:core/models/news.dart';
import 'package:core/models/result_history.dart';
import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNewsList();
  Future<Either<Failure, String>> getNewsImage(String imageUrl);
  Future<Either<Failure, List<Inspection>>> getInspection();
  Future<Either<Failure, List<ResultHistory>>> getResultHistory(String email);
}
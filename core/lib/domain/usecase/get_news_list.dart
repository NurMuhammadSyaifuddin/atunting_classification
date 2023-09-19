import 'package:core/domain/repositories/news_repository.dart';
import 'package:core/models/news.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetNewsList {
  final NewsRepository _newsRepository;

  GetNewsList(this._newsRepository);

  Future<Either<Failure, List<News>>> execute(){
    return _newsRepository.getNewsList();
  }
}
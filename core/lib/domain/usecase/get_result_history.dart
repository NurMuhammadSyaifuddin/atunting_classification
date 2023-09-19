import 'package:core/domain/repositories/news_repository.dart';
import 'package:core/models/result_history.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetResultHistory {
  final NewsRepository _newsRepository;

  GetResultHistory(this._newsRepository);

  Future<Either<Failure, List<ResultHistory>>> execute(String email){
    return _newsRepository.getResultHistory(email);
  }
}
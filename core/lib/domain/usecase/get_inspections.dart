import 'package:core/domain/repositories/news_repository.dart';
import 'package:core/models/inspection.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetInspection {
  final NewsRepository _newsRepository;

  GetInspection(this._newsRepository);

  Future<Either<Failure, List<Inspection>>> execute(){
    return _newsRepository.getInspection();
  }
}
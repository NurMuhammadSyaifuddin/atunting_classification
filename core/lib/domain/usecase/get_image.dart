import 'package:core/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';

class GetImage {
  final NewsRepository newsRepository;

  GetImage(this.newsRepository);

  Future<Either<Failure, String>> execute(String imageUrl){
    return newsRepository.getNewsImage(imageUrl);
  }
}
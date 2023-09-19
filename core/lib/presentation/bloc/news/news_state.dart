import 'package:equatable/equatable.dart';

import '../../../models/news.dart';

abstract class NewsState extends Equatable{}

class InitialNewsState extends NewsState{
  @override
  List<Object?> get props => [];
}

class LoadingNewsState extends NewsState {
  @override
  List<Object?> get props => [];
}

class LoadedNewsState extends NewsState {
  final List<News> listNews;

  LoadedNewsState(this.listNews);

  @override
  List<Object?> get props => [listNews];
}

class ErrorNewsState extends NewsState {
  String message;

  ErrorNewsState(this.message);

  @override
  List<Object?> get props => [message];
}
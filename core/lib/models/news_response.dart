import 'package:core/models/news.dart';
import 'package:equatable/equatable.dart';

class NewsResponse extends Equatable {
  List<News> newsList;

   NewsResponse({required this.newsList});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    newsList: List<News>.from((json["news"] as List)
        .map((x) => News.fromJson(x))
  ));

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(newsList.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [newsList];

}
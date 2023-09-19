import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsListEvent extends NewsEvent{
  @override
  List<Object?> get props => [];
}

class GetImageNewsEvent extends NewsEvent {
  final String imageUrl;

  GetImageNewsEvent(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}
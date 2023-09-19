import 'package:equatable/equatable.dart';

abstract class ResultHistoryEvent extends Equatable {}

class GetResultHistoryEvent extends ResultHistoryEvent{
  String email;

  GetResultHistoryEvent(this.email);

  @override
  List<Object?> get props => [];
}
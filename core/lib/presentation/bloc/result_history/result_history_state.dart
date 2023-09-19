import 'package:equatable/equatable.dart';

import '../../../models/result_history.dart';

abstract class ResultHistoryState extends Equatable{}

class InitialResultHistoryState extends ResultHistoryState{
  @override
  List<Object?> get props => [];
}

class LoadingResultHistoryState extends ResultHistoryState{
  @override
  List<Object?> get props => [];
}

class LoadedResultHistoryState extends ResultHistoryState {
  List<ResultHistory> resultHistory;

  LoadedResultHistoryState(this.resultHistory);

  @override
  List<Object?> get props => [resultHistory];
}

class ErrorResultHistoryState extends ResultHistoryState {
  String message;

  ErrorResultHistoryState(this.message);

  @override
  List<Object?> get props => [message];
}
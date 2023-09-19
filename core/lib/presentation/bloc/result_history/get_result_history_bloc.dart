import 'package:core/domain/usecase/get_result_history.dart';
import 'package:core/presentation/bloc/result_history/result_history_event.dart';
import 'package:core/presentation/bloc/result_history/result_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetResultHistoryBloc extends Bloc<ResultHistoryEvent, ResultHistoryState>{
  final GetResultHistory _getResultHistory;

  GetResultHistoryBloc(this._getResultHistory): super(InitialResultHistoryState()){
    on<GetResultHistoryEvent>((event, emit) async {
      emit(LoadingResultHistoryState());

      final result = await _getResultHistory.execute(event.email);

      result.fold((failure) {
        emit(ErrorResultHistoryState(failure.message));
      }, (data) {
        emit(LoadedResultHistoryState(data));
      });
    });
  }
}
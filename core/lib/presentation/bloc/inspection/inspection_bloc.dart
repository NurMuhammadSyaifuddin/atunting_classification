import 'package:core/domain/usecase/get_inspections.dart';
import 'package:core/presentation/bloc/inspection/inspection_event.dart';
import 'package:core/presentation/bloc/inspection/inspection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetInspectionBloc extends Bloc<InspectionEvent, InspectionState>{
  final GetInspection _getInspection;

  GetInspectionBloc(this._getInspection): super(InitialInspectionState()){
    on<GetInspectionEvent>((event, emit) async {
      emit(LoadingInspectionState());
      final result = await _getInspection.execute();

      result.fold((failure) {
        emit(ErrorInspectionState(failure.message));
      }, (data) {
        emit(LoadedInspectionState(data));
      });
    });
  }

}
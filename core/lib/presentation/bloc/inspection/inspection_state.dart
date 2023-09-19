import 'package:equatable/equatable.dart';

import '../../../models/inspection.dart';

abstract class InspectionState extends Equatable {}

class InitialInspectionState extends InspectionState{
  @override
  List<Object?> get props => [];
}

class LoadingInspectionState extends InspectionState {
  @override
  List<Object?> get props => [];
}

class LoadedInspectionState extends InspectionState {
  List<Inspection> inspections;

  LoadedInspectionState(this.inspections);

  @override
  List<Object?> get props => [inspections];
}

class ErrorInspectionState extends InspectionState {
  String message;

  ErrorInspectionState(this.message);

  @override
  List<Object?> get props => [message];
}
import 'package:equatable/equatable.dart';

abstract class PhotoAnalysisState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInitial extends PhotoAnalysisState {}

class PhotoAnalysisSuccess extends PhotoAnalysisState {}

class PhotoAnalysisFailure extends PhotoAnalysisState {
  final Exception exception;

  PhotoAnalysisFailure(this.exception);

  @override
  List<Object> get props => [exception];
}

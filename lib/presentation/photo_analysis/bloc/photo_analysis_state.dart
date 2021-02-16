import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';

abstract class PhotoAnalysisState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInitial extends PhotoAnalysisState {}

class PhotoAnalysisSuccess extends PhotoAnalysisState {
  final CaptureEventResponse response;

  PhotoAnalysisSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class PhotoAnalysisFailure extends PhotoAnalysisState {
  final Exception exception;

  PhotoAnalysisFailure(this.exception);

  @override
  List<Object> get props => [exception];
}

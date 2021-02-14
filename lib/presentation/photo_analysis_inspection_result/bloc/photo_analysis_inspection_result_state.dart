import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';

abstract class PhotoAnalysisInspectionResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInspectionResultInitial
    extends PhotoAnalysisInspectionResultState {}

class PageLoading extends PhotoAnalysisInspectionResultState {}

class DataConversionFromSuccess extends PhotoAnalysisInspectionResultState {
  final CaptureEventResultResponse response;

  DataConversionFromSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class DataConversionFromFailure extends PhotoAnalysisInspectionResultState {}

class ErrorReportSuccess extends PhotoAnalysisInspectionResultState {}

class EventStatusDoneSuccess extends PhotoAnalysisInspectionResultState {}

class NetworkError extends PhotoAnalysisInspectionResultState {
  final DioError dioError;

  NetworkError(this.dioError);

  @override
  List<Object> get props => [dioError];
}

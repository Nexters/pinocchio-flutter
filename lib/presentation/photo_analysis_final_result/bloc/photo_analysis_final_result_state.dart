import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/result_view_response.dart';

abstract class PhotoAnalysisFinalResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisFinalResultInitial extends PhotoAnalysisFinalResultState {}

class ResultViewDataRequestSuccess extends PhotoAnalysisFinalResultState {
  final ResultViewResponse response;

  ResultViewDataRequestSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class NetworkError extends PhotoAnalysisFinalResultState {
  final DioError dioError;

  NetworkError(this.dioError);

  @override
  List<Object> get props => [dioError];
}

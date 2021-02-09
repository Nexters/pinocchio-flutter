import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/camera_result_response.dart';

abstract class CameraResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraResultInitial extends CameraResultState {}

class PhotoDataRequestLoading extends CameraResultState {}

class PhotoDataRequestSuccess extends CameraResultState {
  final CameraResultResponse response;

  PhotoDataRequestSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class PhotoDataRequestFailure extends CameraResultState {
  final DioError dioError;

  PhotoDataRequestFailure(this.dioError);

  @override
  List<Object> get props => [dioError];
}

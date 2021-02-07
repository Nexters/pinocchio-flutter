import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraFailure extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  final String path;

  CameraCaptureSuccess(this.path);

  @override
  List<Object> get props => [path];
}

class CameraCaptureFailure extends CameraState {}

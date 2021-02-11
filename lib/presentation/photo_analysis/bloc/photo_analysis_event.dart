import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/camera_result_response.dart';

abstract class PhotoAnalysisEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInitialized extends PhotoAnalysisEvent {
  final CameraResultResponse cameraResultResponse;

  PhotoAnalysisInitialized(this.cameraResultResponse);

  @override
  List<Object> get props => [cameraResultResponse];
}

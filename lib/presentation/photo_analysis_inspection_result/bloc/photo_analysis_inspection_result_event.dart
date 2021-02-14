import 'package:equatable/equatable.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';

abstract class PhotoAnalysisInspectionResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInspectionInitialized
    extends PhotoAnalysisInspectionResultEvent {
  final CaptureEventResponse response;

  PhotoAnalysisInspectionInitialized(this.response);

  @override
  List<Object> get props => [response];
}

class ClothesColorTypeSelected extends PhotoAnalysisInspectionResultEvent {
  final int selectedIndex;

  ClothesColorTypeSelected(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

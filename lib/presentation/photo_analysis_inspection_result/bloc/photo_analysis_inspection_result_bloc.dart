import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';

import 'photo_analysis_inspection_result_event.dart';
import 'photo_analysis_inspection_result_state.dart';

class PhotoAnalysisInspectionResultBloc extends Bloc<
    PhotoAnalysisInspectionResultEvent, PhotoAnalysisInspectionResultState> {
  PhotoAnalysisInspectionResultBloc()
      : super(PhotoAnalysisInspectionResultInitial());

  @override
  Stream<PhotoAnalysisInspectionResultState> mapEventToState(
      PhotoAnalysisInspectionResultEvent event) async* {
    if (event is PhotoAnalysisInspectionInitialized) {
      yield* _mapPhotoAnalysisInspectionInitializedToState(event);
    }
  }

  Stream<PhotoAnalysisInspectionResultState>
      _mapPhotoAnalysisInspectionInitializedToState(
          PhotoAnalysisInspectionInitialized event) async* {
    try {
      Map<String, dynamic> map = jsonDecode(event.response.result);
      final resultResponse = CaptureEventResultResponse.fromJson(map);
      yield DataConversionFromSuccess(resultResponse);
    } catch (e) {
      yield DataConversionFromFailure();
    }
  }
}

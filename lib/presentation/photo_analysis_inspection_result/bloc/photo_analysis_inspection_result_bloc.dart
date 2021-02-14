import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';
import 'package:flutter_sancle/data/model/enum/clothes_color_type.dart';

import 'photo_analysis_inspection_result_event.dart';
import 'photo_analysis_inspection_result_state.dart';

class PhotoAnalysisInspectionResultBloc extends Bloc<
    PhotoAnalysisInspectionResultEvent, PhotoAnalysisInspectionResultState> {
  PhotoAnalysisInspectionResultBloc()
      : super(PhotoAnalysisInspectionResultInitial());

  int _selectedIndex = 0;
  final _selectedIndexStreamController = StreamController<int>();

  StreamSink<int> get selectedIndexSink => _selectedIndexStreamController.sink;

  Stream<int> get selectedIndexStream => _selectedIndexStreamController.stream;
  List<ClothesColorType> clothesColorTypes = ClothesColorType.values;

  @override
  Stream<PhotoAnalysisInspectionResultState> mapEventToState(
      PhotoAnalysisInspectionResultEvent event) async* {
    if (event is PhotoAnalysisInspectionInitialized) {
      yield* _mapPhotoAnalysisInspectionInitializedToState(event);
    } else if (event is ClothesColorTypeSelected) {
      _selectedIndex = event.selectedIndex;
      selectedIndexSink.add(_selectedIndex);
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

  void dispose() {
    _selectedIndexStreamController.close();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';
import 'package:flutter_sancle/data/model/capture_event_update_request.dart';
import 'package:flutter_sancle/data/model/enum/clothes_color_type.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';
import 'package:flutter_sancle/data/repository/capture_event_repository.dart';
import 'package:flutter_sancle/presentation/models/photo_analysis_status.dart';

import 'photo_analysis_inspection_result_event.dart';
import 'photo_analysis_inspection_result_state.dart';

class PhotoAnalysisInspectionResultBloc extends Bloc<
    PhotoAnalysisInspectionResultEvent, PhotoAnalysisInspectionResultState> {
  PhotoAnalysisInspectionResultBloc(this._repository)
      : super(PhotoAnalysisInspectionResultInitial());

  final CaptureEventRepository _repository;

  CaptureEventUpdateRequest _eventUpdateRequest;
  String _eventId;

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
      _eventUpdateRequest.result.clothesColor =
          clothesColorTypes[_selectedIndex].toShortString();
    } else if (event is ErrorReportRequested) {
      yield* _mapErrorReportRequestedToState();
    }
  }

  Stream<PhotoAnalysisInspectionResultState>
      _mapPhotoAnalysisInspectionInitializedToState(
          PhotoAnalysisInspectionInitialized event) async* {
    try {
      Map<String, dynamic> map = jsonDecode(event.response.result);
      _eventUpdateRequest = CaptureEventUpdateRequest(
          imageId: event.response.imageId,
          status: event.response.status,
          result: Result.fromJson(map));
      _eventId = event.response.eventId;
      final resultResponse = CaptureEventResultResponse.fromJson(map);
      yield DataConversionFromSuccess(resultResponse);
    } catch (e) {
      yield DataConversionFromFailure();
    }
  }

  Stream<PhotoAnalysisInspectionResultState>
      _mapErrorReportRequestedToState() async* {
    try {
      final tokenResponse = await UserTokenManger.instance.getUserToken();
      _eventUpdateRequest.status = PhotoAnalysisStatus.REPORT.toShortString();
      final statusCode = await _repository.putCaptureEvent(
          _eventId, tokenResponse.userId, _eventUpdateRequest);
      yield ErrorReportSuccess();
    } catch (e) {
      log(e);
    }
  }

  void dispose() {
    _selectedIndexStreamController.close();
  }
}

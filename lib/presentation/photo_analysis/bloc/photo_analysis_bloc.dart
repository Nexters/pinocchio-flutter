import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';
import 'package:flutter_sancle/data/repository/capture_event_repository.dart';
import 'package:flutter_sancle/presentation/models/photo_analysis_status.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_state.dart';

class PhotoAnalysisBloc extends Bloc<PhotoAnalysisEvent, PhotoAnalysisState> {
  final CaptureEventRepository _repository;

  PhotoAnalysisBloc(this._repository) : super(PhotoAnalysisInitial());

  @override
  Stream<PhotoAnalysisState> mapEventToState(PhotoAnalysisEvent event) async* {
    if (event is PhotoAnalysisInitialized) {
      yield* _mapPhotoAnalysisInitializedToState(event);
    }
  }

  Stream<PhotoAnalysisState> _mapPhotoAnalysisInitializedToState(
      PhotoAnalysisInitialized event) async* {
    CaptureEventResponse response;
    bool toContinue = true;
    try {
      await Future.doWhile(() async {
        response = await _repository
            .getCaptureEvent(event.cameraResultResponse.eventId);
        if (response.status == PhotoAnalysisStatus.DONE.toShortString()) {
          return false;
        } else {
          await Future.delayed(Duration(seconds: 3));
          return toContinue;
        }
      }).timeout(Duration(minutes: 5), onTimeout: () {
        toContinue = false;
        throw TimeoutException('캡쳐 이벤트 조회 API 타임아웃');
      });
      yield PhotoAnalysisSuccess(response);
    } catch (e) {
      yield PhotoAnalysisFailure(e);
    }
  }
}

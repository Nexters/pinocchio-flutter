import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/photo_analysis_repository.dart';
import 'package:flutter_sancle/presentation/models/photo_analysis_status.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_state.dart';

class PhotoAnalysisBloc extends Bloc<PhotoAnalysisEvent, PhotoAnalysisState> {
  final PhotoAnalysisRepository _repository;

  PhotoAnalysisBloc(this._repository) : super(PhotoAnalysisInitial());

  @override
  Stream<PhotoAnalysisState> mapEventToState(PhotoAnalysisEvent event) async* {
    if (event is PhotoAnalysisInitialized) {
      yield* _mapPhotoAnalysisInitializedToState(event);
    }
  }

  Stream<PhotoAnalysisState> _mapPhotoAnalysisInitializedToState(
      PhotoAnalysisInitialized event) async* {
    String status;
    bool toContinue = true;
    await Future.doWhile(() async {
      status =
          await _repository.getCaptureEvent(event.cameraResultResponse.eventId);
      if (status == PhotoAnalysisStatus.DONE.toShortString()) {
        return false;
      } else {
        await Future.delayed(Duration(seconds: 3));
        return toContinue;
      }
    }).timeout(Duration(minutes: 5), onTimeout: () {
      toContinue = false;
      throw TimeoutException('Timeout');
    }).catchError((e) async* {
      yield PhotoAnalysisFailure(e);
    });

    if (status == PhotoAnalysisStatus.DONE.toShortString()) {
      yield PhotoAnalysisSuccess();
    } else {
      yield PhotoAnalysisFailure(Exception('Status is not done'));
    }
  }
}

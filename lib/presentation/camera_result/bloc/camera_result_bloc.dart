import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/camera_result_repository.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_event.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_state.dart';

class CameraResultBloc extends Bloc<CameraResultEvent, CameraResultState> {
  final CameraResultRepository _repository;

  CameraResultBloc(this._repository) : super(CameraResultInitial());

  @override
  Stream<CameraResultState> mapEventToState(CameraResultEvent event) async* {
    if (event is PhotoDataRequested) {
      yield* _mapPhotoAnalysisRequestedToState(event);
    }
  }

  Stream<CameraResultState> _mapPhotoAnalysisRequestedToState(
      PhotoDataRequested event) async* {
    yield PhotoDataRequestLoading();
    try {
      final cameraResultResponse =
          await _repository.postUserImage(event.category, event.filePath);
      yield PhotoDataRequestSuccess(cameraResultResponse);
    } on DioError catch (e) {
      yield PhotoDataRequestFailure(e);
    }
  }
}

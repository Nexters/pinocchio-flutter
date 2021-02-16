import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/result_view_repository.dart';
import 'package:flutter_sancle/presentation/photo_analysis_final_result/bloc/photo_analysis_final_result_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis_final_result/bloc/photo_analysis_final_result_state.dart';

class PhotoAnalysisFinalResultBloc
    extends Bloc<PhotoAnalysisFinalResultEvent, PhotoAnalysisFinalResultState> {
  final ResultViewRepository _repository;

  PhotoAnalysisFinalResultBloc(this._repository)
      : super(PhotoAnalysisFinalResultInitial());

  @override
  Stream<PhotoAnalysisFinalResultState> mapEventToState(
      PhotoAnalysisFinalResultEvent event) async* {
    if (event is PhotoAnalysisFinalResultInitialized) {
      yield* _mapPhotoAnalysisFinalResultInitializedToState(event);
    }
  }

  Stream<PhotoAnalysisFinalResultState>
      _mapPhotoAnalysisFinalResultInitializedToState(
          PhotoAnalysisFinalResultInitialized event) async* {
    try {
      final resultViewResponse = await _repository.getViewResult(event.eventId);
      yield ResultViewDataRequestSuccess(resultViewResponse);
    } on DioError catch (e) {
      yield NetworkError(e);
    }
  }
}

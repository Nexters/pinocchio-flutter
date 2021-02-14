import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis_final_result/bloc/photo_analysis_final_result_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis_final_result/bloc/photo_analysis_final_result_state.dart';

class PhotoAnalysisFinalResultBloc
    extends Bloc<PhotoAnalysisFinalResultEvent, PhotoAnalysisFinalResultState> {
  PhotoAnalysisFinalResultBloc() : super(PhotoAnalysisFinalResultInitial());

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
    try {} on DioError catch (e) {}
  }
}

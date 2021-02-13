import 'package:flutter_bloc/flutter_bloc.dart';

import 'photo_analysis_inspection_result_event.dart';
import 'photo_analysis_inspection_result_state.dart';

class PhotoAnalysisInspectionResultBloc extends Bloc<
    PhotoAnalysisInspectionResultEvent, PhotoAnalysisInspectionResultState> {
  PhotoAnalysisInspectionResultBloc()
      : super(PhotoAnalysisInspectionResultInitial());

  @override
  Stream<PhotoAnalysisInspectionResultState> mapEventToState(
      PhotoAnalysisInspectionResultEvent event) {
    // TODO: implement mapEventToState
  }
}

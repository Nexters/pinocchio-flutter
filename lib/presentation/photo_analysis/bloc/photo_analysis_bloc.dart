import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_state.dart';

class PhotoAnalysisBloc extends Bloc<PhotoAnalysisEvent, PhotoAnalysisState> {
  PhotoAnalysisBloc() : super(PhotoAnalysisInitial());

  @override
  Stream<PhotoAnalysisState> mapEventToState(PhotoAnalysisEvent event) async* {
    if (event is PhotoAnalysisInitialized) {}
  }
}

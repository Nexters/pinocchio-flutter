import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_event.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_state.dart';

class CameraResultBloc extends Bloc<CameraResultEvent, CameraResultState> {
  CameraResultBloc() : super(CameraResultInitial());

  @override
  Stream<CameraResultState> mapEventToState(CameraResultEvent event) {
    // TODO: implement mapEventToState
  }
}

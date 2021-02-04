import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_event.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial());

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) {}
}

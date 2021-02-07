import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_event.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial());

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is PictureDataRequested) {
      yield* _mapPictureDataRequestedToState();
    } else if (event is PictureCategoryClicked) {
      yield* _mapPictureCategoryClickedToState(event);
    }
  }

  Stream<CameraState> _mapPictureDataRequestedToState() async* {
    yield PictureDataLoaded(selectedPosition: 0);
  }

  Stream<CameraState> _mapPictureCategoryClickedToState(
      PictureCategoryClicked event) async* {
    yield PictureDataLoaded(selectedPosition: event.selectedPosition);
  }
}

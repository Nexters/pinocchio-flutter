import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_event.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_state.dart';
import 'package:flutter_sancle/presentation/models/picture_category.dart';
import 'package:flutter_sancle/utils/camera_utils.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraUtils cameraUtils;
  final ResolutionPreset resolutionPreset;
  final CameraLensDirection cameraLensDirection;

  CameraBloc({
    @required this.cameraUtils,
    this.resolutionPreset = ResolutionPreset.veryHigh,
    this.cameraLensDirection = CameraLensDirection.back,
  }) : super(CameraInitial());

  int _selectedIndex = 0;
  final _selectedIndexStreamController = StreamController<int>();

  StreamSink<int> get selectedIndexSink => _selectedIndexStreamController.sink;

  Stream<int> get selectedIndexStream => _selectedIndexStreamController.stream;

  List<PictureCategory> pictureCategories = PictureCategory.values;

  PictureCategory getSelectedCategory() => pictureCategories[_selectedIndex];

  CameraController _controller;

  CameraController getController() => _controller;

  bool isInitialized() => _controller?.value?.isInitialized ?? false;

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraInitialized) {
      yield* _mapCameraInitializedToState();
    } else if (event is CameraStopped) {
      yield* _mapCameraStoppedToState();
    } else if (event is CameraCaptured) {
      yield* _mapCameraCapturedToState(event);
    } else if (event is PictureCategoryClicked) {
      _selectedIndex = event.selectedIndex;
      selectedIndexSink.add(_selectedIndex);
    }
  }

  Stream<CameraState> _mapCameraInitializedToState() async* {
    try {
      _controller = await cameraUtils.getCameraController(
          resolutionPreset, cameraLensDirection);
      await _controller.initialize();
      yield CameraReady();
    } on CameraException catch (_) {
      _controller?.dispose();
      yield CameraFailure();
    } catch (_) {
      yield CameraFailure();
    }
  }

  Stream<CameraState> _mapCameraStoppedToState() async* {
    _controller?.dispose();
    yield CameraInitial();
  }

  Stream<CameraState> _mapCameraCapturedToState(CameraCaptured event) async* {
    if (state is CameraReady) {
      try {
        final xFile = await _controller.takePicture();
        yield CameraCaptureSuccess(xFile.path);
      } on CameraException catch (_) {
        yield CameraCaptureFailure();
      }
    }
  }

  void dispose() {
    _controller?.dispose();
    _selectedIndexStreamController.close();
  }
}

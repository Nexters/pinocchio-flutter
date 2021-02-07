import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraInitialized extends CameraEvent {}

class CameraStopped extends CameraEvent {}

class CameraCaptured extends CameraEvent {}

class PictureCategoryClicked extends CameraEvent {
  final int selectedIndex;

  PictureCategoryClicked(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

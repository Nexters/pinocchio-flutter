import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PictureDataRequested extends CameraEvent {}

class PictureCategoryClicked extends CameraEvent {
  final int selectedPosition;

  PictureCategoryClicked(this.selectedPosition);

  @override
  List<Object> get props => [selectedPosition];
}

import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class PictureDataLoaded extends CameraState {
  final List<String> pictureCategories = ['상의', '하의', '양말', '속옷', '수건'];
  final int selectedPosition;

  PictureDataLoaded({this.selectedPosition});

  @override
  List<Object> get props => [selectedPosition];
}
